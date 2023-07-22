({
    init : function(component, event, helper) {
        var action = component.get("c.getAccounts");

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS"){
                var accounts = response.getReturnValue();
                component.set("v.accounts", accounts);
            } else {
                console.error("Error retrieving accounts")
            }
        });

        $A.enqueueAction(action);
    },

    selectAccount: function(component, event, helper) {
        var selectedAccId = event.target.id;
        component.set("v.selectedAccount", selectedAccId);
        helper.loadPayments(component, selectedAccId);
        component.set("v.isFormVisible", true);
    },

    createPayment: function(component, event, helper) {
        helper.insertPayment(component);
    }
})