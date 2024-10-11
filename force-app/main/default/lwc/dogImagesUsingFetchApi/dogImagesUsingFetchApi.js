import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import DogImageGeneratorTitle from '@salesforce/label/c.Dog_Image_Generator_Title';
import DogImageGeneratorButtonLabel from '@salesforce/label/c.Dog_Image_Generator_Button_Label';
import DogApiUrl from '@salesforce/label/c.Dog_Api_Url';
import ErrorMessageForTypeError from '@salesforce/label/c.Error_Message_For_TypeError';
import ErrorMessageForHttpError from '@salesforce/label/c.Error_Message_For_HttpError';
import ErrorMessageForUnexpectedError from '@salesforce/label/c.Error_Message_For_UnexpectedError';
import HTTPLabel from '@salesforce/label/c.HTTP_Label';
import ErrorMessageTitleFetchApi from '@salesforce/label/c.Error_Message_Title_Fetch_Api';

export default class DogImagesUsingFetchApi extends LightningElement {
    imageReady = false;
    pictureUrl = '';
    loadingSpinner = false;
    labels = {
        DogImageGeneratorTitle,
        DogImageGeneratorButtonLabel,
        ErrorMessageForTypeError,
        HTTPLabel,
        DogApiUrl,
        ErrorMessageForHttpError,
        ErrorMessageForUnexpectedError,
        ErrorMessageTitleFetchApi
    }

    handleClick() {
        this.imageReady = false;
        this.loadingSpinner = true;
        fetch(this.labels.DogApiUrl, { method: 'GET' })
            .then(response => response.json())
            .then(data => {
                this.pictureUrl = data.message;
                this.imageReady = true;
                this.loadingSpinner = false;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: this.labels.ErrorMessageTitleFetchApi,
                    message: this.getErrorMessage(error),
                    variant: 'error',
                });
                this.dispatchEvent(event);
                this.loadingSpinner = false;
            });
    }

    getErrorMessage(error) {
        if (error instanceof TypeError) {
            return this.labels.ErrorMessageForTypeError;
        } else if (error.message.includes(this.labels.HTTPLabel)) {
            return this.labels.ErrorMessageForHttpError;
        } else {
            return this.labels.ErrorMessageForUnexpectedError;
        }
    }
}