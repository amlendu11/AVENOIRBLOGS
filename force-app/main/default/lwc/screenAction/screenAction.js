import { LightningElement, api, track, wire } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

const fields = [INDUSTRY_FIELD, PHONE_FIELD];

export default class ScreenAction extends LightningElement {
    @api recordId;
    @track industry;
    @track phone;

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredAccount({ error, data }) {
        if (data) {
            this.account = data.fields;
            this.industry = this.account.Industry.value;
            this.phone = this.account.Phone.value; // Add this line
        } else if (error) {
            this.account = undefined;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading account',
                    message: error.body.message,
                    variant: 'error'
                })
            );
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
            [PHONE_FIELD.fieldApiName]: this.phone // Add this line
        };

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account information updated',
                        variant: 'success'
                    })
                );
                this.closeAction();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
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
}