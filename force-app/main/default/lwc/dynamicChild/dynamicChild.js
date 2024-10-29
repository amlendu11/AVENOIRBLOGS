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
import {LightningElement, api} from 'lwc';
import MESSAGE_FROM_PARENT from "@salesforce/label/c.MESSAGE_FROM_PARENT";
import CHILD_COMPONENT from "@salesforce/label/c.CHILD_COMPONENT";

export default class DynamicChild extends LightningElement {
    @api message;
    label = {
        MESSAGE_FROM_PARENT,
        CHILD_COMPONENT
    }
}