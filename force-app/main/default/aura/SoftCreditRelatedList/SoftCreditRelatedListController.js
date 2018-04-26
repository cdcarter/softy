({
    doInit : function(component, event, helper) {
        var model = {
            total_records : 0,
            tableColumns : [
                {label: 'Opportunity ID', fieldName: 'oppty_id', type: 'text'},
                {label: 'Role', fieldName: 'role', type:'text'},
                {label: 'Partial', fieldName: 'partial', type: 'boolean'}
            ],
            tableData : []
        };
        component.set('v.model', model);
        helper.getRows(component);
    }
})