import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import {dispatchSuccessEvent, dispatchErrorEvent} from 'c/dispatchEvent'
import PAGE_TITLE from '@salesforce/label/c.Title_of_the_page';
import ACCOUNT_NAME from '@salesforce/label/c.Show_Account_Name';
import ACCOUNT_ID from '@salesforce/label/c.Show_Account_Id';
import ACCOUNT_TYPE from '@salesforce/label/c.Account_Type';
import ACCOUNT_PHONE from '@salesforce/label/c.Show_Account_Phone';
import ACCOUNT_NUMBER from '@salesforce/label/c.Show_Account_Account_Number';
import ACCOUNT_INDUSTRY from '@salesforce/label/c.Show_Account_Industry';
import SUCCESS_TITLE from '@salesforce/label/c.Success_Title';
import ERROR_TITLE from '@salesforce/label/c.Error_Title';
import SUCCESS_MESSAGE from '@salesforce/label/c.Success_Message';
import ERROR_MESSAGE from '@salesforce/label/c.Error_Message';
import ADD_ROW from '@salesforce/label/c.Add_Row';
import DELETE_ROW from '@salesforce/label/c.Delete_Row';
import SUBMIT_REQUEST from '@salesforce/label/c.Submit_Request';
export default class InsertMultipleAccounts extends NavigationMixin(LightningElement) {
    keyIndex = 0;
    label = {
        PAGE_TITLE,
        ACCOUNT_NAME,
        ACCOUNT_ID,
        ACCOUNT_TYPE,
        ACCOUNT_PHONE,
        ACCOUNT_NUMBER,
        ACCOUNT_INDUSTRY,
        ADD_ROW,
        DELETE_ROW,
        SUBMIT_REQUEST
    }
    @track itemList = [
        {
            id: 0
        }
    ];

    addRow() {
        ++this.keyIndex;
        let newItem = [{ id: this.keyIndex }];
        this.itemList.push(newItem);
    }

    removeRow(event) {
        if (this.itemList.length >= 2) {
            this.itemList = this.itemList.filter(function (element) {
                return parseInt(element.id) !== parseInt(event.target.accessKey);
            });
        }
    }

    handleSubmit() {
        let isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isVal = isVal && element.reportValidity();
        });
        if (isVal) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                element.submit();
            });
            dispatchSuccessEvent(SUCCESS_TITLE, SUCCESS_MESSAGE);
            // Navigate to the Account home page
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Account',
                    actionName: 'home',
                },
            });
        } else {
            dispatchErrorEvent(ERROR_TITLE, ERROR_MESSAGE);
        }
    }
}