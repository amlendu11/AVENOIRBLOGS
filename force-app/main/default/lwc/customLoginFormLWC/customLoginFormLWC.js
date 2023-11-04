import { LightningElement, track, api, wire } from 'lwc';
import getIsUsernamePasswordEnabled from '@salesforce/apex/LoginController.getIsUsernamePasswordEnabled';
import login from '@salesforce/apex/LoginController.login';
import LINKEDINICON from '@salesforce/resourceUrl/LinkedinIcon';
import INSTAGRAMICON from '@salesforce/resourceUrl/InstagramIcon';
import GOOGLEICON from '@salesforce/resourceUrl/GoogleIcon';
import TWITTERICON from '@salesforce/resourceUrl/TwitterIcon';
import LOGINHERE from '@salesforce/label/c.LOGIN_HERE';
import PASSWORD from '@salesforce/label/c.LOGIN_PASSWORD_PLACEHOLDER';
import LOGIN from '@salesforce/label/c.LOGIN_BUTTON_LABEL';
import USERNAME from '@salesforce/label/c.LOGIN_USERNAME_PLACEHOLDER';
import GOOGLE_URL from '@salesforce/label/c.AVENOIR_GOOGLE_URL';
import INSTAGRAM_URL from '@salesforce/label/c.AVENOIR_INSTAGRAM_URL';
import LINKEDIN_URL from '@salesforce/label/c.AVENOIR_LINKEDIN_URL';
import TWITTER_URL from '@salesforce/label/c.AVENOIR_TWITTER_URL';

export default class CustomLoginFormLWC extends LightningElement {

    isUsernamePasswordEnabled;
    username;
    password;
    icon = {
        LINKEDINICON,
        INSTAGRAMICON,
        GOOGLEICON,
        TWITTERICON
    };
    label = {
        LOGINHERE,
        PASSWORD,
        LOGIN,
        USERNAME,
        GOOGLE_URL,
        INSTAGRAM_URL,
        LINKEDIN_URL,
        TWITTER_URL
    };

    @wire(getIsUsernamePasswordEnabled)
    wiredIsUsernamePasswordEnabled({ error, data }) {
        if (data) {
            this.isUsernamePasswordEnabled = data;
        } else if (error) {
            alert(error);
        }
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    openInstagram() {
        window.location.href = this.label.INSTAGRAM_URL;
    }

    openGoogle() {
        window.location.href = this.label.GOOGLE_URL;
    }

    openTwitter() {
        window.location.href = this.label.TWITTER_URL;
    }

    openLinkedin() {
        window.location.href = this.label.LINKEDIN_URL;
    }

    handleClick(event){
        if(this.username && this.password){
            event.preventDefault();
            login({ username: this.username, password: this.password })
                .then((result) => {
                    if (this.isValidURL(result)) {
                        window.location.href = result;
                    }
                    else {
                        alert(result);
                    }
                })
                .catch((error) => {
                    alert(error);
            });
        }
    }

    isValidURL(url) {
        const urlPattern = /^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$/;
        return urlPattern.test(url);
    }
}