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
1.1        Shiv K Chaudhary   23/09/2024     Update JS and Html
***********************************************************************/
import {LightningElement} from 'lwc';
import HEADING_TEXT from "@salesforce/label/c.Dynamic_Component_Header_Text";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import SELECT_COMPONENT_TO_SHOW from "@salesforce/label/c.SELECT_COMPONENT_TO_SHOW";
import MESSAGE_FOR_CHILD_COMPONENT from "@salesforce/label/c.MESSAGE_FOR_CHILD_COMPONENT";
import LOAD_ACCOUNTCONTACT_COMPONENT from "@salesforce/label/c.LOAD_ACCOUNTCONTACT_COMPONENT";
import LOAD_DYNAMIC_CHILD_COMPONENT from "@salesforce/label/c.LOAD_DYNAMIC_CHILD_COMPONENT";
import ERROR from "@salesforce/label/c.ERROR";
import ERROR_IMPORTING_COMPONENT from "@salesforce/label/c.ERROR_IMPORTING_COMPONENT";
import ACCOUNT_CONTACTS_DISPLAY from "@salesforce/label/c.ACCOUNT_CONTACTS_DISPLAY";
import DYNAMIC_CHILD from "@salesforce/label/c.DYNAMIC_CHILD";

export default class DynamicInstantiateCmp extends LightningElement {
    componentConstructor;
    getComponent;
    message;
    isChildCmp = false;
    label = {
        HEADING_TEXT,
        SELECT_COMPONENT_TO_SHOW,
        MESSAGE_FOR_CHILD_COMPONENT
    }

    // Purpose : Get label and value for radio buttons
    get options() {
        return [
            {label: LOAD_ACCOUNTCONTACT_COMPONENT, value: ACCOUNT_CONTACTS_DISPLAY},
            {label: LOAD_DYNAMIC_CHILD_COMPONENT, value: DYNAMIC_CHILD},
        ];
    }

    // Purpose: This method get value of radio button and insert dynamic component
    handleChange(event) {
        this.getComponent = event.target.value;
        if (this.getComponent == DYNAMIC_CHILD) {
            this.isChildCmp = true;
        }
        else {
            this.isChildCmp = false;
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
            title: ERROR,
            message: ERROR_IMPORTING_COMPONENT,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}