/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG08
------------------------------------------------------------------------
* Blog: Send translated emails via LWC and Apex.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     20/04/2023   Initial Development
***********************************************************************/

import { LightningElement, track } from "lwc";
import sendEmailController from "@salesforce/apex/EmailHandler.sendEmailController";
import languageTranslate from "@salesforce/apex/EmailHandler.languageTranslate";
import ERROR from "@salesforce/label/c.ERROR";
import CLOSE from "@salesforce/label/c.CLOSE";
import RECEIPENT from "@salesforce/label/c.RECEIPENT";
import UPLOAD_FILES from "@salesforce/label/c.UPLOAD_FILES";
import INVALID_EMAIL_MESSAGE from "@salesforce/label/c.INVALID_EMAIL_MESSAGE";
import ATTACH_FILES from "@salesforce/label/c.ATTACH_FILES";
import TRANSLATE from "@salesforce/label/c.TRANSLATE";
import EMAIL_SENDER_NAME from "@salesforce/label/c.EMAIL_SENDER_NAME";
import EMAIL_REPLY_ADDRESS from "@salesforce/label/c.EMAIL_REPLY_ADDRESS";
import SOURCE_LANGUAGE_CODE from "@salesforce/label/c.SOURCE_LANGUAGE_CODE";
import TARGET_LANGUAGE_CODE from "@salesforce/label/c.TARGET_LANGUAGE_CODE";
import SUBJECT from "@salesforce/label/c.SUBJECT";
import SEND from "@salesforce/label/c.SEND";
import RESET from "@salesforce/label/c.RESET";
import TO from "@salesforce/label/c.TO";
import CC from "@salesforce/label/c.CC";

const SVG_ERROR_LINK = "/assets/icons/utility-sprite/svg/symbols.svg#error";
const SVG_CLOSE_LINK = "/assets/icons/utility-sprite/svg/symbols.svg#close";

export default class EmailLWC extends LightningElement {
    toAddress = [];
    ccAddress = [];
    @track files = [];
    sourceLangCode = "";
    targetLangCode = "";
    subject = "";
    body = "";
	error;
    wantToUploadFile = false;
    noError = false;
    invalidEmails = false;
	label = {
        ERROR,
        CLOSE,
        RECEIPENT,
        UPLOAD_FILES,
        INVALID_EMAIL_MESSAGE,
        TO,
        CC,
        RESET,
        SEND,
        SUBJECT,
        TARGET_LANGUAGE_CODE,
        SOURCE_LANGUAGE_CODE,
        EMAIL_REPLY_ADDRESS,
        EMAIL_SENDER_NAME,
        TRANSLATE, ATTACH_FILES
    };

    toggleFileUpload() {
        this.wantToUploadFile = !this.wantToUploadFile;
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        this.files = [...this.files, ...uploadedFiles];
        this.wantToUploadFile = false;
    }

    handleRemove(event) {
        const index = event.target.dataset.index;
        this.files.splice(index, 1);
    }

    handleToAddressChange(event) {
        this.toAddress = event.detail.selectedValues;
    }

    handleCcAddressChange(event) {
        this.ccAddress = event.detail.selectedValues;
    }

    handleSourceChange(event) {
        this.sourceLangCode = event.target.value;
    }

    handleTargetChange(event) {
        this.targetLangCode = event.target.value;
    }

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleBodyChange(event) {
        this.body = event.target.value;
    }

    handleTranslation() {
        languageTranslate({
            Text: this.subject,
            sourceLangCode: this.sourceLangCode,
            targetLangCode: this.targetLangCode
        })
        .then(result => {
            this.subject = result;
        })
        .catch((error) => {
            this.error = error;
        });
        languageTranslate({
            Text: this.body,
            sourceLangCode: this.sourceLangCode,
            targetLangCode: this.targetLangCode
        })
        .then(result => {
            this.body = result;
        })
        .catch((error) => {
            this.error = error;
        });
    }

    validateEmails(emailAddressList) {
        let areEmailsValid;
        if(emailAddressList.length > 1) {
            areEmailsValid = emailAddressList.reduce((accumulator, next) => {
                const isValid = this.validateEmail(next);
                return accumulator && isValid;
            });
        }
        else if(emailAddressList.length > 0) {
            areEmailsValid = this.validateEmail(emailAddressList[0]);
        }
        return areEmailsValid;
    }

    validateEmail(email) {
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(String(email).toLowerCase()))
        {
            return (true)
        }
        alert("You have entered an invalid email address!")
        return (false)
    }

    handleReset() {
        this.toAddress = [];
        this.ccAddress = [];
        this.subject = "";
        this.body = "";
        this.files = [];
        this.sourceLangCode = "";
        this.targetLangCode = "";
        this.template.querySelectorAll("c-email-input").forEach((input) => input.reset());
    }

    handleSendEmail() {
        this.noError = false;
        this.invalidEmails = false;
        if (![...this.toAddress, ...this.ccAddress].length > 0) {
            this.noError = true;
            return;
        }
        if (!this.validateEmails([...this.toAddress, ...this.ccAddress])) {
            this.invalidEmails = true;
            return;
        }
        let emailDetails = {
            toAddress: this.toAddress,
            ccAddress: this.ccAddress,
            subject: this.subject,
            body: this.body
        };
        sendEmailController({emailDetailStr: JSON.stringify(emailDetails)})
            .then(() => {
                alert('Email sent');
                this.handleReset();}
            ).catch((error) => {
                this.error = error;
                alert(error);
            }
        );
    }
}