import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllOpportunities from '@salesforce/apex/OpportunityController.getAllOpportunity';
import CUSTOM_SUCCESS_TITLE_LABEL from '@salesforce/label/c.Custom_Success_Title_Label';
import CUSTOM_SUCCESS_MESSAGE_LABEL from '@salesforce/label/c.Custom_Success_Message_Label_for_Opportunity';
import CUSTOM_SUCCESS_VARIANT_LABEL from '@salesforce/label/c.Custom_Success_Variant_Label';
import CUSTOM_ERROR_TITLE_LABEL from '@salesforce/label/c.Custom_Error_Title_Label';
import CUSTOM_ERROR_MESSAGE_LABEL from '@salesforce/label/c.Custom_Error_Message_Label';
import CUSTOM_ERROR_VARIANT_LABEL from '@salesforce/label/c.Custom_Error_Variant_Label';

const COLS = [
    {
        label: 'Opportunity Name',
        fieldName: 'Name',
        type: 'text',
        editable: false,
    },
    {
        label: 'Account Name',
        fieldName: 'AccountId',
        type: 'lookupColumn',
        typeAttributes: {
            object: 'Opportunity',
            fieldName: 'AccountId',
            value: { fieldName: 'AccountId' },
            context: { fieldName: 'Id' },
            name: 'Account',
            fields: ['Account.Name'],
            target: '_self'
        },
        editable: false,
    },
    {
        label: 'Amount',
        fieldName: 'Amount',
        type: 'currency',
        editable: true
    },
    {
        label: 'Close Date',
        fieldName: 'CloseDate',
        type: 'date',
        editable: true
    }
];

export default class DemoPage extends LightningElement {
    @track columns = COLS;
    @track draftValues = [];
    @track visibleRecords = [];
    @track allOpportunities = [];
    @track error;
    @track isLoading = true;
    wiredOpportunitiesResult;
    @track showModal = false;

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
        draftValues.forEach(element => {
            this.updateDraftValues(element);
        });
    }

    @wire(getAllOpportunities)
    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result;
        if (result.data) {
            this.visibleRecords = result.data.map((item) => {
                const opportunity = item.opportunity;
                const account = opportunity.Account;
                const owner = opportunity.Owner;
                const accountName = account ? account.Name : '';
                return {
                    Id: opportunity.Id,
                    Name: opportunity.Name,
                    AccountId: account ? account.Id : '',
                    Account: accountName,
                    Amount: opportunity.Amount,
                    OwnerName: owner ? owner.Name : '',
                    OwnerId: opportunity.OwnerId, 
                    CloseDate: opportunity.CloseDate
                };
            });
            this.isLoading = false;
        } else if (result.error) {
            this.error = result.error;
            this.isLoading = false;
        }
    }

    lookupChanged(event) {
        event.stopPropagation();
        let dataRecieved = event.detail.data;
        let accountIdVal = dataRecieved.value != undefined ? dataRecieved.value : null;
        let updatedItem = { Id: dataRecieved.context, AccountId: accountIdVal  };
        this.updateDraftValues(updatedItem);
        this.updateDataValues(updatedItem);
    }       

    createAndDispatchToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }

    async handleInlineEditSave(event) {
        const draftValues = event.detail.draftValues;
        if (draftValues.length === 0) {
            return;
        }
        this.draftValues = [];
        const records = draftValues.map(draftValue => ({ fields: { ...draftValue } }));
        try {
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);
            const title = CUSTOM_SUCCESS_TITLE_LABEL;
            const message = CUSTOM_SUCCESS_MESSAGE_LABEL;
            const variant = CUSTOM_SUCCESS_VARIANT_LABEL;
            this.createAndDispatchToast(title, message, variant);
            refreshApex(this.wiredOpportunitiesResult);
        } catch (error) {
            this.createAndDispatchToast(this.customErrorTitle, this.customErrorMessage, this.customErrorVariant);
        }
    }
}