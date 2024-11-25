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
import OPPORTUNITY_NAME from "@salesforce/schema/Opportunity.Name";
import ACCOUNT_NAME from "@salesforce/schema/Opportunity.AccountId";
import OPPORTUNITY_AMOUNT from "@salesforce/schema/Opportunity.Amount";
import OPPORTUNITY_CLOSE_DATE from "@salesforce/schema/Opportunity.CloseDate";
import OPPORTUNITY_NAME_LABEL from '@salesforce/label/c.Opportunity_Name_Label';
import ACCOUNT_NAME_LABEL from '@salesforce/label/c.Account_Name_Label';
import AMOUNT_LABEL from '@salesforce/label/c.Amount_Label';
import CLOSE_DATE_LABEL from '@salesforce/label/c.Close_Date_Label';

const COLS = [
    {
        label: OPPORTUNITY_NAME_LABEL,
        fieldName: OPPORTUNITY_NAME.fieldApiName,
        type: 'text',
        editable: false,
    },
    {
        label: ACCOUNT_NAME_LABEL,
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
        label: AMOUNT_LABEL,
        fieldName: OPPORTUNITY_AMOUNT.fieldApiName,
        type: 'currency',
        editable: true,
    },
    {
        label: CLOSE_DATE_LABEL,
        fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName,
        type: 'date',
        editable: true,
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

    updateDataValues(updateItem) {
        let copyData = JSON.parse(JSON.stringify(this.data));
 
        copyData.forEach(item => {
            if (item.Id === updateItem.Id) {
                for (let field in updateItem) {
                    item[field] = updateItem[field];
                }
            }
        });
        this.data = [...copyData];
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
        let toastEvent = new ShowToastEvent({
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
            this.createAndDispatchToast(CUSTOM_SUCCESS_TITLE_LABEL, CUSTOM_SUCCESS_MESSAGE_LABEL, CUSTOM_SUCCESS_VARIANT_LABEL);
            refreshApex(this.wiredOpportunitiesResult);
        } catch (error) {
            this.createAndDispatchToast(CUSTOM_ERROR_TITLE_LABEL, CUSTOM_ERROR_MESSAGE_LABEL, CUSTOM_ERROR_VARIANT_LABEL);
        }
    }
}