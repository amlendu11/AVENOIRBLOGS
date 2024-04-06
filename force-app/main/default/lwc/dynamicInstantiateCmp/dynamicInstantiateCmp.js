/************************************************************************
(c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.*
Created by: Santosh Kumar
Ticket Number: AVEBLOG-95
------------------------------------------------------------------------*
Blog: Dynamically Import and Instantiate Lightning Web Components
------------------------------------------------------------------------*
Version History:*
VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
1.0        Santosh Kumar      06/03/2024     Initial Development
***********************************************************************/
import {LightningElement} from 'lwc';
import HEADING_TEXT from "@salesforce/label/c.Dynamic_Component_Header_Text";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class DynamicInstantiateCmp extends LightningElement {
    componentConstructor;
    getComponent;
    message;
    isChildCmp = false;
    label = {
        HEADING_TEXT
    }

    // Purpose : Get label and value for radio buttons
    get options() {
        return [
            { label: 'Load AccountContact Component', value: 'accountContactsDisplay' },
            { label: 'Load Dynamic Child Component', value: 'dynamicChild' },
        ];
    }

    // Purpose: This method get value of radio button and insert dynamic component
    handleChange(event) {
        this.getComponent = event.target.value;
        if(this.getComponent == 'dynamicChild') {
            this.isChildCmp = true;
        }
        import("c/" + this.getComponent)
        .then(({ default: ctor }) => (this.componentConstructor = ctor))
        .catch((err) => this.showErrorToast());
    }

    // Purpose : This method get text value from lightning input and set it to message
    handleMessage(event) {
        this.message = event.target.value;
    }

    // Purpose : This method used to Error Toost message when Error occur
    showErrorToast() {
        const event = new ShowToastEvent({
            title: 'ERROR',
            message: 'Error importing component',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}