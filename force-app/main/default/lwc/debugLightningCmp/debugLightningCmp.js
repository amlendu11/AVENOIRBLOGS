/************************************************************************ 
(c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.* 
Created by: Santosh Kumar
Ticket Number: AVEBLOG68
------------------------------------------------------------------------* 
Blog: How to debug standard lightning components.
------------------------------------------------------------------------* 
Version History:* 
VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
1.0        Santosh Kumar        25/09/23     Initial Development   
***********************************************************************/

import { LightningElement,wire,api } from 'lwc';
import { getRecord } from "lightning/uiRecordApi"

const FIELDS = ["Contact.Name", "Contact.Phone","contact.Email"];

export default class DebugLightningCmp extends LightningElement {

    @api recordId;
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