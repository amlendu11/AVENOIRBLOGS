import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import mapFields from '@salesforce/apex/DynamicFieldMappingController.mappedRecord';

export default class DynamicFieldMappingButton extends LightningElement {
    @api recordId;
    
    handleButtonClick() {
        mapFields({ contactId: this.recordId })
            .then(result => {
                if (result[0].isSuccess) {
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: result[0].message,
                        variant: 'success',
                    });
                    this.dispatchEvent(event);
                } 
                else {
                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: result[0].message,
                        variant: 'error',
                    });
                    this.dispatchEvent(event);
                }
            })
            .catch(error => {
                console.error('Error: ', error);
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while mapping fields.',
                    variant: 'error',
                });
                this.dispatchEvent(event);
            });
    }
}