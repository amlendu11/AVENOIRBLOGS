import { LightningElement } from 'lwc';

export default class DebugLightningCmp extends LightningElement {
    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }
    
    handleError(event) {
        const errorMessages = event.detail.detail.error.body.message;
        console.log(errorMessages)
    }
    
}