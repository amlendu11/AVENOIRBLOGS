import {LightningElement, api, track} from 'lwc';
import LightningAlert from 'lightning/alert';
export default class ButtonRedirectToFlow extends LightningElement {
    @track isShowModal = false;
    @api recordId;
    @track inputVariable = [];
    showModalBox() {
        this.isShowModal = true;
        this.inputVariable = [{
            name: "recordId",
            type: "String",
            value: this.recordId
        }]
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
            message: 'Record created Successfully',
            theme: 'success',
            label: 'Create Contact',
        })

    }
}