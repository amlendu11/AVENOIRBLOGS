/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Manish Kumar Gupta
* Ticket Number: AVEBLOG53
--------------------------------------------------------------------
* Blog: Experience Cloud Site login page Development from scratch using LWC
--------------------------------------------------------------------
* Purpose/ Methods: This class is use to check login for Experience Cloud Site
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0     Manish Kumar Gupta    31/10/2023    Initial Development
***********************************************************************/

global class LoginController {

    /**
    * Allows users to log in to the current site, then takes them to the  startUrl. If startUrl is
      not a relative path, it defaults to the site's designated index page.
    * @param : String username, String password
    * @return : System.PageReference
    */
    @AuraEnabled
    public static String login(String username, String password) {
        String result = null;
        try {
            ApexPages.PageReference lgn = Site.login(username, password, '');
            result = (lgn != null) ? lgn.getUrl() : null;
        } catch (Exception ex) {
            result = ex.getMessage();
        }
        return result;
    }

    /**
    * Configure the Site not to request a username and password if it is for unauthenticated users 
      or users logging in with a third-party authentication provider.
    * @param : NA
    * @return : Boolean
    */
    @AuraEnabled(cacheable = true)
    public static Boolean getIsUsernamePasswordEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getUsernamePasswordEnabled();
    }

    /**
    * This method is used to return the user’s current Experience Cloud site.
    * @param : NA
    * @return : User’s current Experience Cloud site(Auth.AuthConfiguration).
    */
    @TestVisible
    private static Auth.AuthConfiguration getAuthConfig() {
        Id networkId = Network.getNetworkId();
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId, '');
        return authConfig;
    }
}