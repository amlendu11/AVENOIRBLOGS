/*******************************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG-112
--------------------------------------------------------------------------------
* Description: lwc component for multiselect options with search for filter
--------------------------------------------------------------------------------
* Version History: (All changes and TA reworks should be entered as new row)
* VERSION     DEVELOPER NAME      DATE          DETAIL FEATURES
* 1.0         Diksha Dewangan   20/12/2023     Initial development
*******************************************************************************/
import { LightningElement, track, api } from 'lwc';
import SELECT_ALL_MESSAGE from '@salesforce/label/c.SELECT_ALL_MESSAGE';
import CLEAR_ALL_MESSAGE from '@salesforce/label/c.CLEAR_ALL_MESSAGE';
import SELECTED_MESSAGE from '@salesforce/label/c.SELECTED_MESSAGE';

export default class multiSelectPicklist extends LightningElement {
    @track allValues = []; // this will store end result or selected values from picklist
    selectedObject = false;
    valuesSelected = undefined;
    showDropdown = false;
    itemcounts = '';
    showselectall = true;
    errors;
    searchKey = '';
    mouse;
    focus;
    blurred;
    labels = {
        SELECT_ALL_MESSAGE,
        CLEAR_ALL_MESSAGE,
        SELECTED_MESSAGE
    };
    @api options;
    @api label;
    @api selectedItems = [];
    @api clearall() {
        this.handleClearall(event);
    }

    //this function is used to filter the dropdown list based on user input
    handleSearch(event) {
        this.searchKey = event.target.value;
        this.showDropdown = true;
        this.mouse = false;
        this.focus = false;
        this.blurred = false;
    }

    //this function is used to show the dropdown list
    get filteredResults() {
        if (this.valuesSelected == undefined) {
            this.valuesSelected = this.options;
            //convert object to array
            Object.keys(this.valuesSelected).map(option => {
                this.allValues.push({ Id: option, Name: this.valuesSelected[option] });
            })
            this.valuesSelected = this.allValues.sort(function (a, b) { return a.Id - b.Id });
            this.allValues = [];
        }
        //if values not selected
        if (this.valuesSelected != null && this.valuesSelected.length != 0) {
            if (this.valuesSelected) {
                const optionNames = this.selectedItems.map(option => option.Name);
                return this.valuesSelected.map(option => {
                    //below logic is used to show check mark (✓) in dropdown checklist
                    const isChecked = optionNames.includes(option.Name);
                    return {
                        ...option,
                        isChecked
                    };
                }).filter(option =>
                    option.Name.toLowerCase().includes(this.searchKey.toLowerCase())
                ).slice(0, 20);
            } else {
                return [];
            }
        }
    }

    //this function is used when user check/uncheck/selects (✓) an item in dropdown picklist
    async handleSelection(event) {
        const optionId = event.target.value;
        const isChecked = event.target.checked;
        //below logic is used to show check mark (✓) in dropdown checklist
        if (isChecked) {
            const selectedOption = this.valuesSelected.find(option => option.Id === optionId);
            if (selectedOption) {
                this.selectedItems = [...this.selectedItems, selectedOption];
                this.allValues.push(optionId);
            }
        } else {
            this.selectedItems = this.selectedItems.filter(option => option.Id !== optionId);
            this.allValues.splice(this.allValues.indexOf(optionId), 1);
        }
        this.itemcounts = this.selectedItems.length > 0 ? this.selectedItems.length + "  " + this.labels.SELECTED_MESSAGE : '';
        if (this.itemcounts == '') {
            this.selectedObject = false;
        } else {
            this.selectedObject = true;
        }
        await this.passSelections();
    }

    //custom function used to close/open dropdown picklist
    clickhandler(event) {
        this.mouse = false;
        this.showDropdown = true;
        this.clickHandle = true;
        this.showselectall = true;
    }

    mousehandler(event) {
        this.mouse = true;
        this.dropdownclose();
    }

    blurhandler(event) {
        this.blurred = true;
        this.dropdownclose();
    }

    focushandler(event) {
        this.focus = true;
    }

    dropdownclose() {
        if (this.mouse == true && this.blurred == true && this.focus == true) {
            this.showDropdown = false;
            this.clickHandle = false;
        }
    }

    //this function is invoked when user deselect/remove (✓) items from dropdown picklist
    async handleRemove(event) {
        const valueRemoved = event.target.name;
        this.selectedItems = this.selectedItems.filter(option => option.Id !== valueRemoved);
        this.allValues.splice(this.allValues.indexOf(valueRemoved), 1);
        this.itemcounts = this.selectedItems.length > 0 ? `${this.selectedItems.length}` + "  " + this.labels.SELECTED_MESSAGE : '';
        if (this.itemcounts == '') {
            this.selectedObject = false;
        } else {
            this.selectedObject = true;
        }
        await this.passSelections();
    }

    //this function is used to deselect/uncheck (✓) all of the items in dropdown picklist
    handleClearall(event) {
        event.preventDefault();
        this.showDropdown = false;
        this.selectedItems = [];
        this.allValues = [];
        this.itemcounts = '';
        this.selectedObject = false;
        this.passSelections();
    }

    //this function is used to select/check (✓) all of the items in dropdown picklist
    selectall(event) {
        event.preventDefault();
        if (this.valuesSelected == undefined) {
            this.valuesSelected = this.picklistinput;
            //convert object to array
            Object.keys(this.valuesSelected).map(option => {
                this.allValues.push({ Id: option, Name: this.valuesSelected[option] });
            })
            this.valuesSelected = this.allValues.sort(function (a, b) { return a.Id - b.Id });
            this.allValues = [];
        }
        this.selectedItems = this.valuesSelected;
        this.itemcounts = this.selectedItems.length +  "  " + this.labels.SELECTED_MESSAGE ;
        this.allValues = [];
        this.valuesSelected.map((value) => {
            for (let property in value) {
                if (property == 'Id') {
                    this.allValues.push(`${value[property]}`);
                }
            }
        });
        this.passSelections();
        this.selectedObject = true;
    }

    //pass the selected items to the parent
    passSelections() {
        let messageEvent = new CustomEvent('selection', {
            detail : {
                data : this.selectedItems,
                label : this.label
            }
        });
        this.dispatchEvent(messageEvent);
    }
}