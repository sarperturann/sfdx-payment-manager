({
    loadPayments : function(component, accId) {
        var action = component.get("c.getPayments");

        action.setParams({
            "accId" : accId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS") {
                var payments = response.getReturnValue();
                component.set("v.payments", payments);
            } else {
                console.error("Error fetching the payments");
            }
        });
        $A.enqueueAction(action);
    },

    insertPayment: function(component) {
        const newPayment = component.get("v.newPayment");
        newPayment.Account__c = component.get("v.selectedAccount");

        console.log(newPayment);

        var action = component.get("c.insertPayment");

        action.setParams({
            "payment": newPayment
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if( state === "SUCCESS") {
                component.set("v.newPayment", {
                    "sobjectType" : "Payment__c",
                    "Payment_Type__c" : 'Service',
                    "Amount__c" : 0,
                    "Due_Date__c" : '',
                    "Account__c": component.get("v.selectedAccount"),
                    "Notes__c": ''
                });
                component.set("v.isFormVisible", true);
                this.loadPayments(component, component.get("v.selectedAccount"));
            } else {
                console.error("Error creating the payment: ", response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})