import { LightningElement, api, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import RESTRICTED_FIELD from '@salesforce/schema/Account.Restricted__c';
import ID_FIELD from '@salesforce/schema/Account.Id';
import getAccountData from '@salesforce/apex/AccountController.getAccountRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HeadlessAction extends LightningElement {
    @api recordId;
    @track title;
    @track message;
    @track varient;


    //calling the invoke method
    @api invoke() {
        console.log('Inside Invoke');
        console.log('current record Id '+this.recordId);
        this.getAccountData();  
    }


    getAccountData(){
        getAccountData({recordId: this.recordId})
        .then((result) => {
            console.log('Promise returned');
            console.log(JSON.stringify(result));
            if(result.account.Restricted__c) {
                console.log('Customer is already Restricted');
                this.showToast('Info', 'Customer is already restricted', 'Info');
            }
            else {
                this.updateAccountRecord();
            }
        })
        .catch((error) =>{
            console.log('error returned' +error);
            this.showToast('Error', 'Error while fetching the account data', 'Error');
        })
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }


    updateAccountRecord() {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[RESTRICTED_FIELD.fieldApiName] = true;
        const recordInput = { fields };
        updateRecord(recordInput)
        .then(() => {
            console.log('inside update record promise');
            this.showToast('Success', 'Customer is restricted', 'Success');
        })
        .catch((error) => {
            console.log('inside update record error');
            this.showToast('Error', 'Error while updating the record', 'Error');
        })
    }

}