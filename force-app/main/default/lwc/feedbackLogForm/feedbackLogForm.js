import {LightningElement, track} from 'lwc';
import {log} from 'lightning/logger';
import userId from '@salesforce/user/Id'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import TITLE from '@salesforce/label/c.TITLE';
import YOUR_FEEDBACK from '@salesforce/label/c.YOUR_FEEDBACK';
import FEEDBACK_NAME from '@salesforce/label/c.FEEDBACK_NAME';
import SUBMIT from '@salesforce/label/c.SUBMIT';
import FEEDBACK_SUBMISSION from '@salesforce/label/c.FEEDBACK_SUBMISSION';
import FEEDBACK_SUCCESS from '@salesforce/label/c.FEEDBACK_SUCCESS';
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
    @track feedback = '';

    handleChange(event) {
        this.feedback = event.target.value;
    }

    handleSubmit() {
        let logData = {
            type: this.label.FEEDBACK_SUBMISSION,
            userId: userId,
            timestamp: new Date().toISOString(),
            feedback: this.feedback
        };
        log(logData);
        this.dispatchEvent(
            new ShowToastEvent({
                title: this.label.SUCCESS,
                message: this.label.FEEDBACK_SUCCESS,
                variant: 'success'
            })
        );
    }
}