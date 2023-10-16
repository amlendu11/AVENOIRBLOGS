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
                if (rtnValue != null) {
                    alert(rtnValue);
                }
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    alert(errors);
                }
            }
        });
        $A.enqueueAction(action);
    },

    getIsUsernamePasswordEnabled : function (component, event, helpler) {
        let action = component.get("c.getIsUsernamePasswordEnabled");
        action.setCallback(this, function(a){
                component.set('v.isUsernamePasswordEnabled', true);
        });
        $A.enqueueAction(action);
    }
})