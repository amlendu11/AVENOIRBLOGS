import { LightningElement, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import RESTRICTED_FIELD from '@salesforce/schema/Account.Restricted__c';
import ID_FIELD from '@salesforce/schema/Account.Id';
import getAccountData from '@salesforce/apex/AccountController.getAccountRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ERROR_MESSAGE from '@salesforce/label/c.Error_Toast_Message_for_HeadlessAction';
import UPDATION_ERROR_MESSAGE from '@salesforce/label/c.Updating_Error_Toast_Message_for_HeadlessAction';
import SUCCESS_MESSAGE from '@salesforce/label/c.Success_Toast_Message_for_HeadlessAction';
import INFO_MESSAGE from '@salesforce/label/c.Info_Toast_Message_for_headlessAction';

export default class HeadlessAction extends LightningElement {
    @api recordId;

    @api invoke() {
        this.getAccountData();  
    }

    getAccountData(){
        getAccountData({recordId: this.recordId})
            .then((result) => {
                if(result.account.Restricted__c) {
                    this.showToast(INFO_MESSAGE.split(',')[0], INFO_MESSAGE.split(',')[1], INFO_MESSAGE.split(',')[2]);
                }
                else {
                    this.updateAccountRecord();
                }
            })
            .catch((error) =>{
                this.showToast(ERROR_MESSAGE.split(',')[0], ERROR_MESSAGE.split(',')[1], ERROR_MESSAGE.split(',')[2]);
            });
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
                this.showToast(SUCCESS_MESSAGE.split(',')[0], SUCCESS_MESSAGE.split(',')[1], SUCCESS_MESSAGE.split(',')[2]);
            })
            .catch((error) => {
                this.showToast(UPDATION_ERROR_MESSAGE.split(',')[0], UPDATION_ERROR_MESSAGE.split(',')[1], UPDATION_ERROR_MESSAGE.split(',')[2]);
            });
    }
}