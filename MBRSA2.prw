#include 'protheus.ch'
#include 'parmtype.ch'

//PROGRAMA DE ATUALIZAÇÃO


user function MBRSA2()

	Local 	cAlias 		:= "SA2"
	local 	cCores 		:= {}
	local 	cFiltra		:= "A2_FILIAL == '" + xFilial('SA2') + "' .And. A2_EST == 'SP'"
	Private cCadastro 	:= "Cadastro MBROWSE"
	Private aRotina 	:= {}
	Private aIndexSA2 	:= {}
	Private bFiltraBrw	:= {|| FilBrowse(cAlias,@aIndexSA2,@cFiltra)}
	
	AADD(aRotina,{"Pesquisar"	, "AxPesqui"	, 0,1})
	AADD(aRotina,{"Visualizar"	, "AxVisual"	, 0,2})
	AADD(aRotina,{"Incluir"		, "U_BInclui"	, 0,3})
	AADD(aRotina,{"Alterar"		, "U_BAltera"	, 0,4})
	AADD(aRotina,{"Excluir"		, "U_BDeleta"	, 0,5})
	AADD(aRotina,{"Legenda"		, "U_BLegenda"	, 0,6})

	dbSelectArea(cAlias)
	dbSetOrder(1)
	
	Eval(bFiltraBrw) //UTILIZANDO FUNCAO PARA UM BLOCO DE CODIGO
	
	dbGoTop() //FICAR NO TOPO DA TABELA
	mBrowse(,,,,cAlias)
	
	EndFilBrw(cAlias,aIndexSA2)

Return

/*----------------------------------------------------------------------
	FUNCAO BInclui - Inclusao
----------------------------------------------------------------------*/
User Function BInclui(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxInclui(cAlias,nReg,nOpc)
	
		if nOpcao == 1 		
			MsgInfo("Inclusao efetuada com sucesso!")
		Else
			MsgAlert("Inclusao cancelada!")
		EndIf
		
Return
			
			
	

