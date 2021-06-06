public class primeiroBotaoController {
    
    @AuraEnabled
    public STATIC ViaCepJson consultaCep(String cepDigitado){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://viacep.com.br/ws/'+cepDigitado+'/json/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        ViaCepJson results = new ViaCepJson();
        System.debug('resultsBefore: '  + results);

        if(response.getStatusCode() == 200){
            results = (ViaCepJson) JSON.deserialize(response.getBody(), ViaCepJson.class);
            System.debug('resultsAfter: ' + results);
            System.debug(results.logradouro);
            System.debug(results.bairro);
        }

        return results;
    }

    @AuraEnabled
    public STATIC boolean atualizaEndereco(String idAcc, String jsonViaCep){
        try{
            
            ViaCepJson results = (ViaCepJson) JSON.deserialize(jsonViaCep, ViaCepJson.class);
            Account acc = [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode FROM Account WHERE Id =: idAcc];
            acc.BillingStreet = results.logradouro;
            acc.BillingCity = results.localidade;
            acc.BillingState = results.uf;
            acc.BillingPostalCode = results.cep;
    
            update acc;    
            return true;
        }catch(Exception ex){
            System.debug('Linha do erro: ' + ex.getLineNumber());
            System.debug('Mensagem de erro: ' + ex.getMessage());
            return false;
        }       
    }
}