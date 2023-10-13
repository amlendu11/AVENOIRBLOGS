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
const pathItems = [
    { label : 'Create Account', value : 'cmp1', visible : false },
    { label : 'Create Contact', value : 'cmp2', visible : false },
    { label : 'Create Opportunity', value : 'cmp3', visible : false }
];
const pathElements = ['cmp1','cmp2','cmp3'];
export{ pathItems, pathElements };