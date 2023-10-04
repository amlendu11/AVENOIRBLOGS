({
    handleLogin: function (component, event, helpler) {
        let username = component.find("username").get("v.value");
        let password = component.find("password").get("v.value");
        let action = component.get("c.login");
        let startUrl = component.get("v.startUrl");
        startUrl = decodeURIComponent(startUrl);
        action.setParams({ username: username, password: password, startUrl: startUrl });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let rtnValue = response.getReturnValue();
                component.set("v.errorMessage", response.getReturnValue());
                component.set("v.showError", true);
                if (rtnValue === "success") {
                    console.log("Login successful!");
                }
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    console.error(errors);
                }
                component.set("v.errorMessage", $A.get("$Label.c.SITE_LOGIN_ERROR_MESSAGE"));
                component.set("v.showError", true);
            }
        });
        $A.enqueueAction(action);
    },

    getIsUsernamePasswordEnabled : function (component, event, helpler) {
        let action = component.get("c.getIsUsernamePasswordEnabled");
        action.setCallback(this, function(a){
                component.set('v.isUsernamePasswordEnabled',true);
        });
        $A.enqueueAction(action);
    },
})