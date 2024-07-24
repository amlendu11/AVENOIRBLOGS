import { LightningElement, track} from 'lwc';
import {loadScript} from 'lightning/platformResourceLoader';
import CountDown from '@salesforce/resourceUrl/CountDown';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ERROR from "@salesforce/label/c.ERROR";
import LOAD_SCRIPT_ERROR from "@salesforce/label/c.LOAD_SCRIPT_ERROR";
import COUNT_DOWN_HEADING from "@salesforce/label/c.COUNT_DOWN_HEADING";
import COUNT_DOWN_MESSAGE from "@salesforce/label/c.COUNT_DOWN_MESSAGE";
import COUNT_DOWN_SUB_HEADING from "@salesforce/label/c.COUNT_DOWN_SUB_HEADING";
import COUNT_DOWN_LINK_TEXT from "@salesforce/label/c.COUNT_DOWN_LINK_TEXT";
import AVENOIR_GOOGLE_URL from "@salesforce/label/c.AVENOIR_GOOGLE_URL";
export default class ThirdPartyWebComponentInLWC extends LightningElement {
    scriptLoaded = false
    @track showTimer = false;
    time;
    label = {
        COUNT_DOWN_HEADING : COUNT_DOWN_HEADING,
        COUNT_DOWN_MESSAGE : COUNT_DOWN_MESSAGE,
        COUNT_DOWN_SUB_HEADING : COUNT_DOWN_SUB_HEADING,
        COUNT_DOWN_LINK_TEXT : COUNT_DOWN_LINK_TEXT,
        AVENOIR_GOOGLE_URL : AVENOIR_GOOGLE_URL
    }

    renderedCallback() {
        if(this.scriptLoaded) {
            return;
        }
        else {
            loadScript(this, CountDown)
            .then(() => {
                this.getCurrentDateTimePlusTwoMinutes();
                this.scriptLoaded = true;
                this.showTimer = true;
            })
            .catch((error) => {
                this.showToastEvent(
                    ERROR,
                    LOAD_SCRIPT_ERROR,
                    ERROR
                );
            })
        }
    }

    getCurrentDateTimePlusTwoMinutes() {
        let now = new Date();
        now.setMinutes(now.getMinutes() + 1);
        let year = now.getFullYear();
        let month = String(now.getMonth() + 1).padStart(2, '0');
        let day = String(now.getDate()).padStart(2, '0');
        let hours = String(now.getHours()).padStart(2, '0');
        let minutes = String(now.getMinutes()).padStart(2, '0');
        let seconds = String(now.getSeconds()).padStart(2, '0');
        this.time = `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;
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