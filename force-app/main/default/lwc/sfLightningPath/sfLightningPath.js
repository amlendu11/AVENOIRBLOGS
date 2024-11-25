/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Nikhil Mehra
* Ticket Number: AVEBLOG59
------------------------------------------------------------------------
* Blog: How to add field-path like opportunity in LWC Component
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Nikhil Mehra       08/10/2023      Initial Development
***********************************************************************/
import {LightningElement, api} from 'lwc';
import {pathItems, pathElements} from 'c/paths';
export default class SfLightningPath extends LightningElement {
    @api currentState = '';
    @api steps;
    @api currentStepIndex;

    pathElements = pathElements;
    pathHandler(event)
    {
        if(this.pathElements.indexOf(this.currentState)>this.pathElements.indexOf(event.currentTarget.value)) {
            this.currentState = event.currentTarget.value;
            this.dispatchEvent(new CustomEvent('selectedpath', {
                detail: this.currentState
            }));
        }
        
    }
}