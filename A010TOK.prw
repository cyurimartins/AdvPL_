#include 'protheus.ch'
#include 'parmtype.ch'

/*

DESCRIÇÃO: PROGRAMANDO UM PONTO DE ENTRADA. 

O CLIENTE SOLICITA O DESENVOLVIMENTO DE UMA TRATATIVA NO SISTEMA ERP DA EMPRESA, ONDE NÃO PODE SER PERMITIDO QUE O USUÁRIO INCLUA PRODUTOS DO TIPO "PA" 
COM A CONTA CONTABIL "001"

*/

user function A010TOK()

    local lExecuta := .T.
    local cTipo := AllTrim(M->B1_TIPO) //LIMPA TODOS OS ESPAÇOS EM BRANCO DE UMA STRING
    local cConta := AllTrim(M->B1_CONTA)

    If (cTipo = "PA" .AND. cConta = "001")
        Alert("A Conta <b> " + cConta + "</b> não pode estar" + ;
        "associada a um produto do tipo <b>" + cTipo) //AdvPL ACEITA ALGUMAS TAGS EM HTML

        lExecuta := .F.

    EndIf

return(lExecuta)
