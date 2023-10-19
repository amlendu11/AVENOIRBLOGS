({
    initialize: function(component, event, helper) {
        component.set('v.isUsernamePasswordEnabled', helper.getIsUsernamePasswordEnabled(component, event, helper));
    },

    handleLogin: function (component, event, helpler) {
        helpler.handleLogin(component, event, helpler);
    },
})