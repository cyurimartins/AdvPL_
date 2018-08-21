#include 'protheus.ch'
#include 'parmtype.ch'

User Function DEBUG01()

    Local aArea := GetArea()
    Local aProduto := {}
    Local nCount := 0

    //SELECIONA A TABELA DE PRODUTOS

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) //SELECIONA O INDICE
    SB1->(DbGoTop())

    While ! SB1->(EoF()) //ENQUANTO NAO FOR FINAL DO ARQUIVO
        AADD(aProduto, {
            SB1->B1_COD, ;
            SB1->B1_DESC
        })
        nCount++
        SB1->(DbSkip())
    EndDo

    MsgAlert("Quantidade de Produtos encontrada: <b>" + cValToChar(nCount))

    nCount := 0 //zerando o valor da variavel nCount

    RestArea(aArea)


Return
