global class LightningLoginFormController {

    @AuraEnabled
    public static String login(String username, String password, String startUrl) {
        try{
            ApexPages.PageReference lgn = Site.login(username, password, startUrl);
            aura.redirect(lgn);
            return null;
        }
        catch (Exception ex) {
            return ex.getMessage();
        }
    }

    @AuraEnabled
    public static Boolean getIsUsernamePasswordEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getUsernamePasswordEnabled();
    }

    @TestVisible
    private static Auth.AuthConfiguration getAuthConfig() {
        Id networkId = Network.getNetworkId();
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId, '');
        return authConfig;
    }
}