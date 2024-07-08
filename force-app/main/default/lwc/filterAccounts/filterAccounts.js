/*******************************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG-112
--------------------------------------------------------------------------------
* Description: lwc component for filtering the requirement records
--------------------------------------------------------------------------------
* Version History: (All changes and TA reworks should be entered as new row)
* VERSION     DEVELOPER NAME      DATE          DETAIL FEATURES
* 1.0         Diksha Dewangan   22/06/2024     Initial development
*******************************************************************************/
import { LightningElement, track } from 'lwc';
import picklistOptions from '@salesforce/apex/PicklistValuesController.getPicklistValues';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import ACCOUNT_FILTER_HEADING from '@salesforce/label/c.ACCOUNT_FILTER_HEADING';
import NO_RESULTS_MESSAGE from '@salesforce/label/c.NO_RESULTS_MESSAGE';

export default class AccountFilter extends LightningElement {
    industryOptions = [];
    typeOptions = [];
    ratingOptions = [];
    ownershipOptions = [];
    selectedIndustries = [];
    selectedTypes = [];
    selectedRatings = [];
    selectedOwnerships = [];
    allAccounts = [];
    filteredAccounts = [];
    error;
    showError = false;
    labels = {
      ACCOUNT_FILTER_HEADING,
      NO_RESULTS_MESSAGE
    }
    columns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Type', fieldName: 'Type', type: 'text' },
        { label: 'Rating', fieldName: 'Rating', type: 'text' },
        { label: 'Ownership', fieldName: 'Ownership', type: 'text' }
    ];
    filteringfields = ['Industry', 'Type', 'Rating', 'Ownership'];
    @track searchResults = []; //store the search result
    @track selectedValuesByLabel = {}; //stores the latest selectedValues json

    connectedCallback() {
        this.getAccountsData();
        this.setPicklistOptions();
    }

    getAccountsData(){
        getAccounts()
        .then( result => {
            this.filteredAccounts = result;
            this.searchResults = this.filteredAccounts.map(wrapper => wrapper.account);
        })
        .catch(error => {})
    }

    setPicklistOptions() {
        picklistOptions({
            objectApiName: 'Account',
            fieldNames: this.filteringfields
        }).then(result => {
            // Iterate over the keys of the object
            let data = result;
            for (const key in result) {
                if (data.hasOwnProperty(key)) {
                    // Iterate over the values of each key
                    for (const value of data[key]) {
                        if (`${key}` === 'Industry') {
                            this.industryOptions = data[key];
                        } else if (`${key}` === 'Type') {
                            this.typeOptions = data[key];
                        } else if (`${key}` === 'Rating') {
                            this.ratingOptions = data[key];
                        } else if (`${key}` === 'Ownership') {
                            this.ownershipOptions = data[key];
                        }
                    }
                }
            }
        }).catch(error => {
            this.error = error;
        })
    }

    addSelections(event) {
        const {label, selectedValues} = event.detail;
        this.selectedValuesByLabel[label] = event.detail.data;
        // make the search set
        this.makeFilterObject();
    }

    //handles the object formation in [key :[searchkey]] and removing of the childvalues of no [searchkey]
    makeFilterObject() {
        let objectFormat = this.selectedValuesByLabel;
        //stores the searchKey to searchArray
        let filterValues = {};
        for (let key in objectFormat) {
            if (objectFormat.hasOwnProperty(key)) {
                filterValues[`${key}`] = [];
                for (let item of objectFormat[key]) {
                    filterValues[`${key}`].push(item.Name);
                }
            }
        }
        filterValues = Object.fromEntries(
            Object.entries(filterValues).filter(([key, value]) => value.length > 0)
        );
        this.performFilter(filterValues);
    }

    //handles filtering of records
    performFilter(filterValues) {
        try{
            let dataToFilter = this.filteredAccounts;
            let filteredRecords = dataToFilter.filter(record => {
                return this.filteringfields.every(field => {
                    // Convert to lowercase for case-insensitive comparison
                    const fieldValue = record.account && record.account[field]
                        ? record.account[field].toString().toLowerCase()
                        : '';
                    const filterValue = filterValues[field];
                    if (Array.isArray(filterValue)) {
                        return filterValue.some(value => fieldValue.includes(
                            value.toString().toLowerCase())
                        );
                    } else if (typeof filterValue === 'string') {
                        return fieldValue.includes(filterValue.toLowerCase());
                    }
                    return true;
                });
            });
            this.searchResults = filteredRecords.map(wrapper => wrapper.account);
            if (this.searchResults.length == 0) {
                this.showError = true;
                this.error = this.labels.NO_RESULTS_MESSAGE;
            }
            else {
                this.error = undefined;
            }
        }catch(error) {
            this.showError = true;
            this.error = error.message;
            this.searchResults = [];
        }
    }
}