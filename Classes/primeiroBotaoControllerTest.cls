@isTest
public class primeiroBotaoControllerTest {
    
    @isTest
    static void testConsultaCep(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('viaCepJson');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        ViaCepJson result = primeiroBotaoController.consultaCep('01001-000');
        System.assertNotEquals(null, result);
    }

    @isTest
    static void testAtualizaEndTrue(){
        Account acc = new Account(Name = 'accTest');
        insert acc;
        String json = '{"bairro":"Sé","cep":"01001-000","complemento":"lado ímpar","ddd":"11","gia":"1004","ibge":"3550308","localidade":"São Paulo","logradouro":"Praça da Sé","siafi":"7107","uf":"SP"}';

        System.assertEquals(true, primeiroBotaoController.atualizaEndereco(acc.Id, json));
    }

    @isTest
    static void testAtualizaEndFalse(){
        String json = '{"bairro":"Sé","cep":"01001-000","complemento":"lado ímpar","ddd":"11","gia":"1004","ibge":"3550308","localidade":"São Paulo","logradouro":"Praça da Sé","siafi":"7107","uf":"SP"}';
        System.assertEquals(false, primeiroBotaoController.atualizaEndereco('', json));
    }
}
