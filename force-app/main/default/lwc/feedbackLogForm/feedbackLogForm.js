import {LightningElement} from 'lwc';
import {log} from 'lightning/logger';
import userId from '@salesforce/user/Id'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import TITLE from '@salesforce/label/c.TITLE';
import YOUR_FEEDBACK from '@salesforce/label/c.YOUR_FEEDBACK';
import FEEDBACK_NAME from '@salesforce/label/c.FEEDBACK_NAME';
import SUBMIT from '@salesforce/label/c.SUBMIT';
import FEEDBACK_SUBMISSION from '@salesforce/label/c.FEEDBACK_SUBMISSION';
import SUCCESS from '@salesforce/label/c.SUCCESS';

export default class FeedbackForm extends LightningElement {
    label = {
        TITLE,
        YOUR_FEEDBACK,
        FEEDBACK_NAME,
        FEEDBACK_SUBMISSION,
        FEEDBACK_SUCCESS,
        SUCCESS,
        SUBMIT
    };
    handleSubmit() {
        let feedback = this.template.querySelector('lightning-input').value;
        let logData = {
            type: this.FEEDBACK_SUBMISSION,
            userId: userId,
            timestamp: new Date().toISOString(),
            feedback: feedback
        };
        log(logData);
        this.dispatchEvent(
            new ShowToastEvent({
                title: this.SUCCESS,
                message: this.FEEDBACK_SUCCESS,
                variant: 'success'
            })
        );
    }
}