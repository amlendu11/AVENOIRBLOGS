import { LightningElement } from 'lwc';
import { log } from 'lightning/logger';
import userId from '@salesforce/user/Id'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class FeedbackForm extends LightningElement {
    handleSubmit() {
        let feedback = this.template.querySelector('lightning-input').value;

        let logData = {
            type: "feedback_submission",
            userId: userId,
            timestamp: new Date().toISOString(),
            feedback: feedback
        };

        log(logData);
        this.showToast('Success', 'Feedback submitted successfully', 'success');
    }
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
}