import { LightningElement,wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi"

const FIELDS = ["Contact.Name", "Contact.Phone","contact.Email"];

export default class DebugLightningCmp extends LightningElement {

    recordId = "003H4000001jJqiIAE";
    contactData;
    error;


    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    wiredRecord({ error, data }) {
        if(data) {
            console.log(JSON.stringify(data));
            this.contactData = data;
        }else if(error) {
            console.log(JSON.stringify(error));
            this.error = error;
        }
    }

    //Edit form 
    
    handleSubmit(event) {
        event.preventDefault();      
        const fields = event.detail.fields;
        console.log(JSON.stringify(fields));
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }

    handleSuccess(event) {
        console.log(JSON.stringify(event));
        console.log('onsuccess event recordEditForm', event.detail.id);
    }

    handleError(event) {
        console.log(JSON.stringify(event));
        console.log('SomeError Occur');
    }
    
}