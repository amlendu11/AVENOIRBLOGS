import { LightningElement, api, track } from 'lwc';
import LightningAlert from 'lightning/alert';
import CREATE_CONTACT from '@salesforce/label/c.Create_Contact';
import CLOSE from '@salesforce/label/c.CLOSE';
import MESSAGE from '@salesforce/label/c.Record_Created_Successfully';

export default class ButtonRedirectToFlow extends LightningElement {
    label = {
        CREATE_CONTACT,
        CLOSE,
        MESSAGE
    };
    @track isShowModal = false;
    @api recordId;
    @track inputVariable = [];

    showModalBox() {
        this.isShowModal = true;
        this.inputVariable = [{
            name: "recordId",
            type: "String",
            value: this.recordId
        }];
    }

    connectedCallback() {
        this.recordId = this.recordId;
    }

    hideModalBox() {
        this.isShowModal = false;
    }

    async handleFinish() {
        this.isShowModal = false;
        await LightningAlert.open({
            message: this.label.MESSAGE,
            theme: 'success',
            label: this.label.CREATE_CONTACT,
        });
    }

    handleFlowStatusChange(event) {
        if (event.detail.status === 'FINISHED') {
            this.handleFinish();
        }
    }
}
