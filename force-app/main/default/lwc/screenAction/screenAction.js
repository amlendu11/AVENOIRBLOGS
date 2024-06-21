import { LightningElement, api, track, wire } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import Account_Basic_Information from '@salesforce/label/c.Account_Basic_Information';
import Cancel_Button from '@salesforce/label/c.Cancel_Button';
import Update_Account_Button from '@salesforce/label/c.Update_Account_Button';
import Success_Title from '@salesforce/label/c.Success_Title';
import Success_Message from '@salesforce/label/c.Success_Message';
import Error_Title from '@salesforce/label/c.Error_Title';


const fields = [INDUSTRY_FIELD, PHONE_FIELD];

export default class ScreenAction extends LightningElement {
    @api recordId;
    @track industry;
    @track phone;

    label = {
        accountBasicInformation: Account_Basic_Information,
        cancelButton: Cancel_Button,
        updateAccountButton: Update_Account_Button
    };

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredAccount({ error, data }) {
        if (data) {
            this.account = data.fields;
            this.industry = this.account.Industry.value;
            this.phone = this.account.Phone.value;
        } 
    }

    industryOptions = [
        { label: 'Agriculture', value: 'Agriculture' },
        { label: 'Banking', value: 'Banking' },
        { label: 'Construction', value: 'Construction' },
        { label: 'Consulting', value: 'Consulting' },
        { label: 'Education', value: 'Education' }
    ];

    handleUpdateAccount() {
        const fields = {
            Id: this.recordId,
            [INDUSTRY_FIELD.fieldApiName]: this.industry,
            [PHONE_FIELD.fieldApiName]: this.phone
        };

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.showToast(Success_Title, Success_Message,'success');
                this.closeAction();
            })
            .catch(error => {
                this.showToast(Error_Title, error.body.message, 'error');
            });
    }

    closeAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleIndustryChange(event) {
        this.industry = event.detail.value;
    }

    handlePhoneChange(event) {
        this.phone = event.target.value;
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}