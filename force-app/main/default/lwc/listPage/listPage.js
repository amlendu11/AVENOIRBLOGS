import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { loadStyle } from 'lightning/platformResourceLoader';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllLeads from '@salesforce/apex/LeadController.getAllLeads';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import NAME_FIELD from '@salesforce/schema/Lead.Name';
import PHONE_FIELD from '@salesforce/schema/Lead.Phone';
import EMAIL_FIELD from '@salesforce/schema/Lead.Email';
import STATUS_FIELD from '@salesforce/schema/Lead.Status';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

const COLS = [
  {
    label: 'Name',
    fieldName: NAME_FIELD.fieldApiName,
    type: 'text',
    sortable: true,
    editable: false,
  },
  {
    label: 'Phone',
    fieldName: PHONE_FIELD.fieldApiName,
    type: 'phone',
    sortable: true,
    editable: true,
  },
  {
    label: 'Email',
    fieldName: EMAIL_FIELD.fieldApiName,
    type: 'email',
    sortable: true,
    editable: true,
  },
  {
    label: 'Lead Status',
    fieldName: 'Status',
    type: 'picklistColumn',
    editable: true,
    typeAttributes: {
      placeholder: 'Edit Status',
      options: { fieldName: 'pickListOptions' },
      value: { fieldName: 'Type' },
      context: { fieldName: 'Id' },
    },
  },
  {
    label: 'Owner Alias',
    fieldName: 'OwnerAlias',
    type: 'text',
    sortable: true,
    editable: false,
  },
];

export default class listPage extends LightningElement {
  @track columns = COLS;
  @track draftValues = [];
  @track visibleRecords = [];
  @track allLeads = [];
  @track error;
  @track isLoading = true;
  @track dropdownVisible = false;
  @track pickListOptions;
  wiredLeadsResult;

  statusOptions = [
    { label: 'New', value: 'New' },
    { label: 'No Contact', value: 'No Contact' },
    { label: 'Contacted', value: 'Contacted' },
    { label: 'Qualified', value: 'Qualified' },
    { label: 'Not Qualified-Closed', value: 'Not Qualified-Closed' },
  ];

  @wire(getObjectInfo, { objectApiName: LEAD_OBJECT })
  objectInfo;

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: STATUS_FIELD
  })
  wirePickList({ error, data }) {
    if (data) {
      this.pickListOptions = data.values;
    } else if (error) {
      console.log(error);
    }
  }

  updateDraftValues(updateItem) {
    let draftValueChanged = false;
    let copyDraftValues = [...this.draftValues];
    copyDraftValues.forEach(item => {
      if (item.Id === updateItem.Id) {
        for (let field in updateItem) {
          item[field] = updateItem[field];
        }
        draftValueChanged = true;
      }
    });

    if (draftValueChanged) {
      this.draftValues = [...copyDraftValues];
    } else {
      this.draftValues = [...copyDraftValues, updateItem];
    }
  }

  handleCellChange(event) {
    let draftValues = event.detail.draftValues;
    draftValues.forEach(ele => {
      this.updateDraftValues(ele);
    });
  }

  get dropdownStyle() {
    return this.dropdownVisible ? 'display: block;' : 'display: none;';
  }

  toggleDropdown() {
    this.dropdownVisible = !this.dropdownVisible;
  }

  handleOptionSelect(event) {
    const selectedValue = event.currentTarget.dataset.value;
    this.selectedList = selectedValue;
    this.toggleDropdown();
  }

  @wire(getAllLeads, { pickList: '$pickListOptions' })
  wiredLeads(result) {
    this.wiredLeadsResult = result;
    if (result.data) {
      this.visibleRecords = result.data.map((lead) => ({
        Id: lead.leads.Id,
        Name: lead.leads.Name,
        Phone: lead.leads.Phone,
        Email: lead.leads.Email,
        Status: lead.leads.Status,
        OwnerAlias: lead.leads.Owner ? lead.leads.Owner.Alias : '',
        pickListOptions: this.pickListOptions,
      }));
      this.isLoading = false;
    } else if (result.error) {
      this.error = result.error;
      this.isLoading = false;
    }
  }


  async handleInlineEditSave(event) {
    const draftValues = event.detail.draftValues;
    if (draftValues.length === 0) {
      return;
    }
    const records = draftValues.map((draftValue) => {
      const fields = { ...draftValue };
      return { fields };
    });

    this.draftValues = [];

    try {
      const recordUpdatePromises = records.map((record) =>
        updateRecord(record)
      );
      await Promise.all(recordUpdatePromises);
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Success',
          message: 'Leads updated',
          variant: 'success',
        })
      );
      refreshApex(this.wiredLeadsResult);
    } catch (error) {
      let errorMessage = 'Error updating or reloading Leads';
      if (error.body && error.body.message) {
        errorMessage = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error',
          message: errorMessage,
          variant: 'error',
        })
      );
    }
  }
}