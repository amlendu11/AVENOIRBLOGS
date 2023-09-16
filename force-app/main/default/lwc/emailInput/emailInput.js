/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG08
------------------------------------------------------------------------
* Blog: Send translated emails via LWC and Apex.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     20/04/2023   Initial Development
***********************************************************************/
import { LightningElement, track, api } from "lwc";

const ENTER_KEY_CODE = 13;
const BLUR_TIMEOUT_VALUE = 300;
const SVG_ACCOUNT_LINK = "/assets/icons/standard-sprite/svg/symbols.svg#account";

export default class EmailInput extends LightningElement {
    @track items = [];
    searchTerm = "";
    blurTimeout;
    boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus";
    _selectedValues = [];
    selectedValuesMap = new Map();

    get selectedValues() {
        return this._selectedValues;
    }

    set selectedValues(value) {
        this._selectedValues = value;
        const selectedValuesEvent = new CustomEvent(
            "selection", {detail: {selectedValues: this._selectedValues}
        });
        this.dispatchEvent(selectedValuesEvent);
    }

    get hasItems() {
        return this.items.length;
    }

    handleBlur() {
        this.blurTimeout = setTimeout(() => {
            this.boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus";
            const value = this.template.querySelector('input.input').value
            if (value !== undefined && value != null && value !== "") {
                this.selectedValuesMap.set(value, value);
                this.selectedValues = [...this.selectedValuesMap.keys()];
            }
            this.template.querySelector('input.input').value = "";
        }, BLUR_TIMEOUT_VALUE);
    }

    handleKeyPress(event) {
        if (event.keyCode === ENTER_KEY_CODE) {
            event.preventDefault();
            const value = this.template.querySelector('input.input').value;
            if (value !== undefined && value != null && value !== "") {
                this.selectedValuesMap.set(value, value);
                this.selectedValues = [...this.selectedValuesMap.keys()];
            }
            this.template.querySelector('input.input').value = "";
        }
    }

    handleRemove(event) {
        const item = event.target.label;
        this.selectedValuesMap.delete(item);
        this.selectedValues = [...this.selectedValuesMap.keys()];
    }

    onSelect(event) {
        this.template.querySelector('input.input').value = "";
        let value = event.currentTarget;
        let selectedId = value.dataset.id;
        let selectedValue = this.items.find((record) => record.Id === selectedId);
        this.selectedValuesMap.set(selectedValue.Email, selectedValue.Name);
        this.selectedValues = [...this.selectedValuesMap.keys()];
        let key = this.uniqueKey;
        const valueSelectedEvent = new CustomEvent("valueselect", {
            detail: { selectedId, key }
        });
        this.dispatchEvent(valueSelectedEvent);
        if (this.blurTimeout) {
            clearTimeout(this.blurTimeout);
        }
        this.boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus";
    }

    @api reset() {
        this.selectedValuesMap = new Map();
        this.selectedValues = [];
    }

    @api validate() {
        this.template.querySelector('input').reportValidity();
        const isValid = this.template.querySelector('input').checkValidity();
        return isValid;
    }
}