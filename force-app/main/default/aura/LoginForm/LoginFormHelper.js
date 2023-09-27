({
    handleLogin: function (component, event, helpler) {
        var username = component.find("username").get("v.value");
        var password = component.find("password").get("v.value");
        var action = component.get("c.login");
        var startUrl = component.get("v.startUrl");
        startUrl = decodeURIComponent(startUrl);
        action.setParams({ username: username, password: password, startUrl: startUrl });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var rtnValue = response.getReturnValue();
                component.set("v.errorMessage", response.getReturnValue());
                component.set("v.showError", true);
                if (rtnValue === "success") {
                    console.log("Login successful!");
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    console.error(errors);
                }
                component.set("v.errorMessage", "An unexpected error occurred. Please try again later.");
                component.set("v.showError", true);
            }
        });
        $A.enqueueAction(action);
    },

    getIsUsernamePasswordEnabled : function (component, event, helpler) {
        var action = component.get("c.getIsUsernamePasswordEnabled");
        action.setCallback(this, function(a){
                component.set('v.isUsernamePasswordEnabled',true);
        });
        $A.enqueueAction(action);
    },
})