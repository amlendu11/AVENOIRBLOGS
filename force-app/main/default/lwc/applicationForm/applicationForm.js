/************************************************************************
(c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.*
Created by: Manish Kumar Gupta
Ticket Number: AVEBLOG-108
------------------------------------------------------------------------*
Blog: Create a record using rest API(for Customer Community Plus users) using session id as a token.
------------------------------------------------------------------------*
Version History:*
VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
1.0       Manish Kumar Gupta     24/12/2024   Initial Development
***********************************************************************/
import {LightningElement, track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CalloutExample from '@salesforce/apex/ApplicationFormContoller.calloutExample';
import APPLICATION from '@salesforce/schema/Application__c';
import CONTACT_ICON from '@salesforce/label/c.CONTACT_ICON';
import APPLICATION_NAME from '@salesforce/label/c.APPLICATION_NAME';
import APPLICATION_FORM from '@salesforce/label/c.APPLICATION_FORM';
import APPLICATION_SELECTION from '@salesforce/label/c.APPLICATION_SELECTION';
import BUTTON_LABEL from '@salesforce/label/c.CREATE_APPLICATION_BUTTON_LABEL';

export default class ApplicationForm extends LightningElement {

    @track name = '';
    @track isChecked = false;
    labels = {
        CONTACT_ICON,
        APPLICATION_NAME,
        APPLICATION_FORM,
        APPLICATION_SELECTION,
        BUTTON_LABEL
    }

    selectionChange(event) {
        this.isChecked = event.target.checked;
    }

    nameChange(event) {
        this.name = event.target.value;
    }

    handleSubmit() {
        CalloutExample({ objectApiName: APPLICATION.objectApiName, name: this.name, isSelected: this.isChecked })
        .then(result => {
            this.showToast('Success', this.name + ' Application Created Successfully!', 'success');
        })
        .catch(error => {
            this.showToast('Error', error.body.message, 'error');
        });
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