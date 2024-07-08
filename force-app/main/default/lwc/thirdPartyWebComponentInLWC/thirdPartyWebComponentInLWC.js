import { LightningElement } from 'lwc';
import {loadScript} from 'lightning/platformResourceLoader';
import CountDown from '@salesforce/resourceUrl/CountDown';
export default class ThirdPartyWebComponentInLWC extends LightningElement {
    scriptLoaded = false
    time;
    connectedCallback() {
        this.template.addEventListener('startTimer', this.handleStartTimer);
        this.template.addEventListener('stopTimer', this.handleStopTimer);
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
            })
            .catch(() => {
                console.log('Error while loading Script');
            })
        }
    }

    getCurrentDateTimePlusTwoMinutes() {
        const now = new Date();
        now.setMinutes(now.getMinutes() + 2); // Add 2 minutes to the current time
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
        this.time =  `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;
    }

    handleStartTimer(event) {
        console.log('Timer started');
        console.log('Remaining time:', event.detail);
    }
    
    handleStopTimer(event) {
        console.log('Timer stopped');
        console.log('Remaining time:', event.detail);
    }
}