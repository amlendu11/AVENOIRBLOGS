import { LightningElement, api, track, wire } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import LWCDatatablePicklist from '@salesforce/resourceUrl/LWCDatatablePicklist';
import { getRecord } from "lightning/uiRecordApi";
 
export default class lookupColumn extends LightningElement {
    @api value;
    @api fieldName;
    @api object;
    @api context;
    @api name;
    @api fields;
    @api target;
    @track showLookup = false;
 
    @wire(getRecord, { recordId: '$value', fields: '$fields' })
    record;
 
    getFieldName() {
        return (this.fields[0]?.split('.').pop()) || '';
    }

    get lookupName() {
        return (this.value && this.record?.data?.fields[this.getFieldName()]?.value) ?? '';
    }

    get lookupValue() {
        return (this.value && this.record?.data?.fields[this.getFieldName()]?.value) ? '/' + this.value : '';
    }

    renderedCallback() {
        Promise.all([
            loadStyle(this, LWCDatatablePicklist),
        ]).then(() => { });
 
        let container = this.template.querySelector('div.container');
        container?.focus();
 
        window.addEventListener('click', (evt) => {
           if(container == undefined){
               this.showLookup = false;
           }
        });
    }
 
    handleChange(event) {
        this.value = event.detail.value[0];
        if(this.value == undefined){
            this.record.data = null;
        }
        this.dispatchEvent(new CustomEvent('lookupchanged', {
            composed: true,
            bubbles: true,
            cancelable: true,
            detail: {
                data: { context: this.context, value: this.value }
            }
        }));
    }
 
    handleClick(event) {
        setTimeout(() => {
            this.showLookup = true;
        }, 100);
    }
}