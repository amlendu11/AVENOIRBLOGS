import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export function dispatchSuccessEvent(title, message) {
    const successEvent = new ShowToastEvent({
        title: title,
        message: message,
        variant: 'success'
    });
    dispatchEvent(successEvent);
}

export function dispatchErrorEvent(title, message) {
    const errorEvent = new ShowToastEvent({
        title: title,
        message: message,
        variant: 'error'
    });
    dispatchEvent(errorEvent);
}