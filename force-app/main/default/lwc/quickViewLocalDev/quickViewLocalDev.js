/************************************************************************
(c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.*
Created by: Sourav Dash
Ticket Number: AVEBLOG-128
------------------------------------------------------------------------*
Blog: Real-Time Preview for Lightning Web Components
------------------------------------------------------------------------*
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0       Sourav Dash         17/10/2024    Initial Development
***********************************************************************/
import {LightningElement} from 'lwc';
import title from '@salesforce/label/c.LOCAL_DEV';
import message from '@salesforce/label/c.Quick_View_in_Local_Dev';
import footer from '@salesforce/label/c.Card_Footer123565475675';

export default class QuickViewLocalDev extends LightningElement {
    label = {
        title,
        message,
        footer
    }
}