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
import { LightningElement, api } from 'lwc';

export default class DynamicChild extends LightningElement {
    @api message;
}