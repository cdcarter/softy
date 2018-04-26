({
    getRows : function(component) {
        component.set('v.isLoadingDataTable', true);
        var action = component.get('c.getDataForContact');
        action.setParams({contactId: component.get('v.recordId')});
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnValue = response.getReturnValue();
 				var model = component.get('v.model');
 				model.tableData = model.tableData.concat(returnValue.soft_credits);
 				model.total_records = returnValue.total_records;
                component.set('v.model', model);
 				component.set('v.isLoadingDataTable', false);
 				component.set('v.isLoadingComponent', false);
            } else if (state === "ERROR") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "message": "There was an error."
                });
                toastEvent.fire();
                return;
            }
        }));
        $A.enqueueAction(action);
    }
 })