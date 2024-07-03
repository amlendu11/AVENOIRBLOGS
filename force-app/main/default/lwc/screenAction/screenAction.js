import {LightningElement, api, track, wire} from 'lwc';
import {getRecord, updateRecord} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {CloseActionScreenEvent} from 'lightning/actions';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_BASIC_INFORMATION from '@salesforce/label/c.Account_Basic_Information';
import CANCEL_BUTTON from '@salesforce/label/c.Cancel_Button';
import UPDATE_ACCOUNT_BUTTON from '@salesforce/label/c.Update_Account_Button';
import SUCCESS_TITLE from '@salesforce/label/c.Success_Title';
import SUCCESS_MESSAGE from '@salesforce/label/c.Success_Message';
import ERROR_TITLE from '@salesforce/label/c.Error_Title';
import INDUSTRY_LABEL from '@salesforce/label/c.Industry_Label';
import INDUSTRY_PLACEHOLDER from '@salesforce/label/c.Industry_Placeholder';

const fields = [INDUSTRY_FIELD, PHONE_FIELD];
let recordInput = {};

export default class ScreenAction extends LightningElement {
    @api recordId;
    @track industry;
    @track phone;

    industryOptions = [
        { label: 'Agriculture', value: 'Agriculture' },
        { label: 'Banking', value: 'Banking' },
        { label: 'Construction', value: 'Construction' },
        { label: 'Consulting', value: 'Consulting' },
        { label: 'Education', value: 'Education' }
    ];

    label = {
        industryLabel: INDUSTRY_LABEL,
        industryPlaceholder: INDUSTRY_PLACEHOLDER,
        accountBasicInformation: ACCOUNT_BASIC_INFORMATION,
        cancelButton: CANCEL_BUTTON,
        updateAccountButton: UPDATE_ACCOUNT_BUTTON
    };

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredAccount({ error, data }) {
        if (data) {
            this.account = data.fields;
            this.industry = this.account.Industry.value;
            this.phone = this.account.Phone.value;
        } else if (error) {
            this.account = undefined;
            this.showToast(ERROR_TITLE, error.body.message, 'error');
        }
    }

    handleUpdateAccount() {
        recordInput = {
            fields: {
                Id: this.recordId,
                [INDUSTRY_FIELD.fieldApiName]: this.industry,
                [PHONE_FIELD.fieldApiName]: this.phone
            }
        };
        updateRecord(recordInput)
            .then(() => {
                this.showToast(SUCCESS_TITLE, SUCCESS_MESSAGE, 'success');
                this.closeAction();
            })
            .catch(error => {
                this.showToast(ERROR_TITLE, error.body.message, 'error');
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