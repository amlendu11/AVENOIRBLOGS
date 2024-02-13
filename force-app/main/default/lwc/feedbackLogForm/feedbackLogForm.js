import {LightningElement} from 'lwc';
import {log} from 'lightning/logger';
import userId from '@salesforce/user/Id'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import TITLE from '@salesforce/label/c.TITLE';
import YOUR_FEEDBACK from '@salesforce/label/c.YOUR_FEEDBACK';
import FEEDBACK_NAME from '@salesforce/label/c.FEEDBACK_NAME';
import SUBMIT from '@salesforce/label/c.SUBMIT';

export default class FeedbackForm extends LightningElement {
    label = {
        TITLE,
        YOUR_FEEDBACK,
        FEEDBACK_NAME,
        SUBMIT
    };
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