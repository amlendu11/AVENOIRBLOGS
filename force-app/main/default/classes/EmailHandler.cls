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

/**
* This class aims to translate the user-input in the target language
* @param : N/A
* @return : users List of users
*/
public with sharing class EmailHandler {

    /**
    * This method aims to take the user-email to send the translated text
    * @param : receipentEmail - email of the receipent
    * @return : N/A
    */
    @AuraEnabled
    public static void sendEmailController(String emailDetailStr) {
        EmailWrapper emailDetails = (EmailWrapper)JSON.deserialize(
            emailDetailStr,
            EmailWrapper.class
        );
        Messaging.reserveSingleEmailCapacity(1);
        try {
            messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
            mail.setToAddresses(emailDetails.toAddress);
            mail.setCcAddresses(emailDetails.ccAddress);
            mail.setReplyTo(label.EMAIL_REPLY_ADDRESS);
            mail.setSenderDisplayName(label.EMAIL_SENDER_NAME);
            mail.setSubject(emailDetails.subject);
            mail.setHtmlBody(emailDetails.body);
            mail.setEntityAttachments(emailDetails.files);
            Messaging.sendEmail(new List<messaging.SingleEmailMessage>{ mail });
        } catch (exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * This method aims to translate the user-input in the target language
    * @param : text - user input
    * @param : sourceLangCode - Source Language code(ISO- format)
    * @param : targetLangCode - Target Language code(ISO- format)
    * @return : Translated text in target language
    */
    @AuraEnabled(cacheable = true)
    public static String languageTranslate(
        String Text,
        String sourceLangCode,
        String targetLangCode
    ) {
        Http http = new http();
        Httprequest req = new httprequest();
        req.setEndpoint('Callout:Translation_API');
		req.setMethod('POST');
        String body = 'q=' + Text + '&target=' + targetLangCode + '&source=' + sourceLangCode;
        req.setBody(body);
        Httpresponse response = http.send(req);
        Map<String,Object> data = (Map<String,Object>)((Map<String,Object>)JSON.deserializeUntyped(
            response.getBody())
        ).get('data');
        object translations = (object)data.get('translations');
        String ans = JSON.serialize(translations).split(':')[1].substringBetween('"');
        return ans;
    }

    /**
    * This class aims to wrap the Email
    * @param : N/A
    * @return : N/A
	*/
    Class EmailWrapper {
        public List<String> toAddress;
        public List<String> ccAddress;
        public String subject;
        public String body;
        public List<String> files;
    }
}