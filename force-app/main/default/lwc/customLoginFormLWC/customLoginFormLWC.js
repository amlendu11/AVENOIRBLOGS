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

    handleUsernameChange(event) {
        this.username = event.target.value;
    }
    
    openInstagram() {
        window.location.href = label.INSTAGRAM_URL;
    }
    openGoogle() {
        window.location.href = label.GOOGLE_URL;
    }
    openTwitter() {
        window.location.href = label.TWITTER_URL;
    }

    openLinkedin() {
        window.location.href = label.LINKEDIN_URL;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    @wire(getIsUsernamePasswordEnabled)
    wiredIsUsernamePasswordEnabled({ error, data }) {
        if (data) {
            this.isUsernamePasswordEnabled = data;
        } else if (error) {
            console.alert(error);
        }
    }

    handleClick(event){
        if(this.username && this.password){
            event.preventDefault();
            login({ username: this.username, password: this.password })
                .then((result) => {
                    console.log('result ',result);
                    window.location.href = result;
                })
                .catch((error) => {
                    console.alert(error);
            });
        }
    }
}