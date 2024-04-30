import {LightningElement, track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ERROR from "@salesforce/label/c.ERROR";
import SUCCESS from "@salesforce/label/c.Custom_Success_Title_Label";
import ACCOUNT_NAME_REQUIRED from "@salesforce/label/c.ACCOUNT_NAME_REQUIRED";
import ACCOUNT_NAME from "@salesforce/label/c.ACCOUNT_NAME";
import ACCOUNT_PHONE from "@salesforce/label/c.ACCOUNT_PHONE";
import ACCOUNT_NUMBER from "@salesforce/label/c.ACCOUNT_NUMBER";
import ACCOUNTS_INSERTED from "@salesforce/label/c.ACCOUNTS_INSERTED";
import CREATE_ACCOUNTS from "@salesforce/label/c.CREATE_ACCOUNTS";
import insertMultipleAccountRecord from "@salesforce/apex/InsertMultipleRecordController.insertMultipleAccountRecord";
import {NavigationMixin} from 'lightning/navigation';

export default class InsertMultipleRecord extends NavigationMixin(LightningElement) {
    @track accountsToCreate = [];
    label = {
        ERROR: ERROR,
        SUCCESS: SUCCESS,
        ACCOUNT_NAME_REQUIRED: ACCOUNT_NAME_REQUIRED,
        ACCOUNT_NAME: ACCOUNT_NAME,
        ACCOUNT_PHONE: ACCOUNT_PHONE,
        ACCOUNT_NUMBER: ACCOUNT_NUMBER,
        ACCOUNTS_INSERTED: ACCOUNTS_INSERTED,
        CREATE_ACCOUNTS: CREATE_ACCOUNTS
    }
    recordCount = 0;
    saveButtonLabel;

    connectedCallback() {
        this.addRow();
    }

    addRow(event) {
        this.accountsToCreate.push(this.initialNewRecord());
        this.saveButtonLabel = `Save Records (${this.accountsToCreate.length})`;
    }

    handleAddRow(event) {
        let index = parseInt(event.target.dataset.index);
        if (
            this.accountsToCreate[index].accountName == "" ||
            !this.accountsToCreate[index].accountName
        ) {
            let rowNo = index + 1;
            this.showToastEvent(
                this.label.ERROR,
                `${this.label.ACCOUNT_NAME_REQUIRED} ${rowNo}`,
                this.label.ERROR
            )
            return;   
        }
        this.accountsToCreate[index].showAddButton = false;
        this.accountsToCreate[index].showDeleteButton = true;
        this.addRow(event);
        this.accountsToCreate[index + 1].showDeleteButton = true;

    }

    handleDeleteRow(event) {
        if (this.accountsToCreate.length > 1) {
            let index = event.target.dataset.index
            if (index == this.accountsToCreate.length - 1) {
                this.accountsToCreate[index - 1].showAddButton = true;
            }
            this.accountsToCreate.splice(index, 1);
        }
        if (this.accountsToCreate.length == 1) {
            this.accountsToCreate[0].showDeleteButton = false;
        }
        this.saveButtonLabel = `Save Records (${this.accountsToCreate.length})`;
    }

    handleChange(event) {
        this.accountsToCreate[event.target.dataset.index][event.target.name] =
            event.target.value;
    }

    handleSave(event) {
        for (let index in this.accountsToCreate) {
            if (
                this.accountsToCreate[index].accountName == '' ||
                !this.accountsToCreate[index].accountName
            ) {
                let rowNo = parseInt(index) + 1;
                this.showToastEvent(
                    this.label.ERROR,
                    `${this.label.ACCOUNT_NAME_REQUIRED} ${rowNo}`,
                    this.label.ERROR
                )
                return;
            }
        }
        this.insertRecords();
    }

    insertRecords() {
        insertMultipleAccountRecord({ accounts: JSON.stringify(this.accountsToCreate) })
            .then((result) => {
                this.showToastEvent(this.label.SUCCESS, this.label.ACCOUNTS_INSERTED, this.label.SUCCESS);
                this[NavigationMixin.Navigate]({
                    type: "standard__objectPage",
                    attributes: {
                        objectApiName: "Account",
                        actionName: "list",
                    },
                    state: {
                        filterName: "Recent"
                    },
                });
            })
            .catch((error) => {
                this.showToastEvent(this.label.ERROR, error.body.errorMessage, this.label.ERROR);
            })
    }

    initialNewRecord() {
        return ({
            accountName: '',
            accountPhone: '',
            accountNumber: '',
            showAddButton: true,
            showDeleteButton: false
        });
    }

    showToastEvent(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}