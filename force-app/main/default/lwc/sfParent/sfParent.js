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
import { LightningElement, api } from 'lwc';
import { pathItems, pathElements } from 'c/paths';
import accountAPIName from '@salesforce/schema/Account';
import contactAPIName from '@salesforce/schema/Contact';
import opportunityAPIName from '@salesforce/schema/Opportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class SfParent extends NavigationMixin(LightningElement) {

    step = 1;
    pathItems = pathItems;
    pathElements = pathElements;
    currentPath = pathElements[0];
    Account = accountAPIName;
    Contact = contactAPIName;
    Opportunity = opportunityAPIName; 
    accountId;

    get isStep1(){
        return this.step === 1
    }
    get isStep2(){
        return this.step === 2
    }
    get isStep3(){
        return this.step === 3
    }

    handleChangePath(event){
        this.step = event.detail;
        this.currentPath = this.pathElements[this.step];
    }

    backHandler(event){
        this.step = this.step-1;
        this.currentPath = this.pathElements[this.step-1];
    }

    nextHandler(event){
        this.step = this.step+1;
        this.currentPath = this.pathElements[this.step-1];
    }

    handleSuccess(event){ 
       this.accountId = event.detail.id;
    }

    handleSuccessOppo(){
        const evt = new ShowToastEvent({
            title: 'Registration Completed',
            message: 'Thank you for filling form, you will redirect to Account Page',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.navigateToViewAccountPage(this.accountId);
    }

    navigateToViewAccountPage(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
    }
}