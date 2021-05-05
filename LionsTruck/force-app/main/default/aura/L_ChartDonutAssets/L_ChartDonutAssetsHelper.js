({
    doInit: function (component, event, helper) {
    },
    
    scriptsLoaded : function(component, event, helper) {
        var recordId = component.get("v.recordId");        
        var action = component.get("c.getDataSet");
        
        action.setParams({
            "accountId" : recordId
        })
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset=[] ;
                val.forEach(function(key) {
                    labelset.push(key.label) ; 
                    dataset.push(key.count) ; 
                });
                
                var ctx = component.find('donut-chart').getElement().getContext('2d');
                window.chart = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels:labelset,
                        datasets: [{
                            label: '',
                            backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9"],
                            data: dataset
                        }]
                    },
                    options: {
                        title: {
                            display: true,
                            text: 'Trucks Purchased by Model'
                        }
                    }
                });
            }
        });
        $A.enqueueAction(action);
    }
})