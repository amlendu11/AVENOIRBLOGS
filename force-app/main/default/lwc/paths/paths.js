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
   2.0       Shiv k Chaudhary   25/11/2024      Fixed Indentation issue
***********************************************************************/
const pathItems = [
    { label : 'Create Account', value : 'accountComponent', visible : false },
    { label : 'Create Contact', value : 'contactComponent', visible : false },
    { label : 'Create Opportunity', value : 'opportunityComponent', visible : false }
];
const pathElements = ['accountComponent', 'contactComponent', 'opportunityComponent'];
export{pathItems, pathElements};