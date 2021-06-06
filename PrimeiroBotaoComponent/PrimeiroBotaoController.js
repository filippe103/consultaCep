({
    doInit : function(component, event, helper) {
        console.log('Id do registro: ' + component.get('v.recordId'));
    },
    
    cancel : function(component, event, helper){
        var dismissActionPanel = $A.get('e.force:closeQuickAction');
        dismissActionPanel.fire();
    },
    
    searchCEP : function(component, event, helper){
        var action = component.get('c.consultaCep');
        action.setParams({
            cepDigitado : component.get('v.CEP')
        })
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log('Response CEP: ' + response.getReturnValue());
                component.set("v.retornoViaCEP", response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type"    : "success",
                    "title"   : "Deu Bom!!",
                    "message" : "Consulta realizada com sucesso!!"
                });
                toastEvent.fire();
            }else{
                console.log("error!");
            }
        });
        $A.enqueueAction(action);
    },

    salvarEndereco : function(component, event, helper){
        var action = component.get('c.atualizaEndereco');
        action.setParams({
            idAcc : component.get('v.recordId'),
            jsonViaCep : JSON.stringify(component.get('v.retornoViaCEP'))
        })

        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS'){
                console.log(response.getReturnValue());
                if(response.getReturnValue()){
                    var toastEvent = $A.get('e.force:showToast');
                    toastEvent.setParams({
                        'type'    : 'success',
                        'title'   : 'Success!',
                        'message' : 'Registro atualizado com sucesso!'
                    });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();
                    var dismissActionPanel = $A.get('e.force:closeQuickAction');
                    dismissActionPanel.fire();
                }else{
                    console.log('Error');
                }
            }else{
                console.log('Error');
            }
        });
        $A.enqueueAction(action);
    }
})