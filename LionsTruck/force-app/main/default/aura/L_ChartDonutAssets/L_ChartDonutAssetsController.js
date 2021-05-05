({
    doInit: function (component, event, helper) {        
    },
    
    scriptsLoaded : function(component, event, helper) {
        helper.scriptsLoaded(component, event, helper);
    },
    
    afterRefreshView: function (component, event, helper) {
        helper.scriptsLoaded(component, event, helper);
    }
})