/************************************************************************
(c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.*
Created by: Manish Kumar Gupta
Ticket Number: AVEBLOG-109
------------------------------------------------------------------------*
Blog: Making REST Api callout using LWC component
------------------------------------------------------------------------*
Version History:*
VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
1.0       Manish Kumar Gupta     02/10/2024   Initial Development
***********************************************************************/
import {LightningElement} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import DOG_IMAGE_GENERATOR_TITLE from '@salesforce/label/c.DOG_IMAGE_GENERATOR_TITLE';
import DOG_IMAGE_GENERATOR_BUTTON_LABEL from '@salesforce/label/c.DOG_IMAGE_GENERATOR_BUTTON_LABEL';
import DOG_API_URL from '@salesforce/label/c.DOG_API_URL';
import ERROR_MESSAGE_FOR_TYPE_ERROR from '@salesforce/label/c.ERROR_MESSAGE_FOR_TYPE_ERROR';
import ERROR_MESSAGE_FOR_HTTP_ERROR from '@salesforce/label/c.ERROR_MESSAGE_FOR_HTTP_ERROR';
import ERROR_MESSAGE_FOR_UNEXPECTED_ERROR from '@salesforce/label/c.ERROR_MESSAGE_FOR_UNEXPECTED_ERROR';
import HTTP_LABEL from '@salesforce/label/c.HTTP_LABEL';
import ERROR_MESSAGE_TITLE_FETCH_API from '@salesforce/label/c.ERROR_MESSAGE_TITLE_FETCH_API';

export default class DogImagesUsingFetchApi extends LightningElement {
    imageReady = false;
    pictureUrl = '';
    loadingSpinner = false;
    labels = {
        DOG_IMAGE_GENERATOR_TITLE,
        DOG_IMAGE_GENERATOR_BUTTON_LABEL,
        ERROR_MESSAGE_FOR_TYPE_ERROR,
        HTTP_LABEL,
        DOG_API_URL,
        ERROR_MESSAGE_FOR_HTTP_ERROR,
        ERROR_MESSAGE_FOR_UNEXPECTED_ERROR,
        ERROR_MESSAGE_TITLE_FETCH_API
    }

    handleClick() {
        this.imageReady = false;
        this.loadingSpinner = true;
        fetch(this.labels.DOG_API_URL, {method: 'GET'})
            .then(response => response.json())
            .then(data => {
                this.pictureUrl = data.message;
                this.imageReady = true;
                this.loadingSpinner = false;
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: this.labels.ERROR_MESSAGE_TITLE_FETCH_API,
                    message: this.getErrorMessage(error),
                    variant: 'error',
                });
                this.dispatchEvent(event);
                this.loadingSpinner = false;
            });
    }

    getErrorMessage(error) {
        let errorMessage = '';
        if (error instanceof TypeError) {
            errorMessage = this.labels.ERROR_MESSAGE_FOR_TYPE_ERROR;
        } else if (error.message.includes(this.labels.HTTP_LABEL)) {
            errorMessage = this.labels.ERROR_MESSAGE_FOR_HTTP_ERROR;
        } else {
            errorMessage = this.labels.ERROR_MESSAGE_FOR_UNEXPECTED_ERROR;
        }
        return errorMessage;
    }
}