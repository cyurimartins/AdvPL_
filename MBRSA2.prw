#include 'protheus.ch'
#include 'parmtype.ch'

//PROGRAMA DE ATUALIZAÇÃO


user function MBRSA2()

	Local 	cAlias 		:= "SA2"
	local 	aCores 		:= {}
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

	//Acores - Legenda
	
	AADD(aCores,{"A2_TIPO == 'F'",	"BR_VERDE"		})
	AADD(aCores,{"A2_TIPO == 'J'",	"BR_AMARELO"	})
	AADD(aCores,{"A2_TIPO == 'X'",	"BR_LARANJA"	})
	AADD(aCores,{"A2_TIPO == 'R'",	"BR_MARROM"		})
	AADD(aCores,{"EMPTY(A2_TIPO)",	"BR_PRETO"		})
	
	dbSelectArea(cAlias)
	dbSetOrder(1)
	
	Eval(bFiltraBrw) //UTILIZANDO FUNCAO PARA UM BLOCO DE CODIGO
	
	dbGoTop() //FICAR NO TOPO DA TABELA
	mBrowse(,,,,cAlias,,,,,,aCores)
	
	EndFilBrw(cAlias,aIndexSA2)

Return

/*----------------------------------------------------------------------
	FUNCAO BInclui - Incluir
----------------------------------------------------------------------*/
User Function BInclui(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxInclui(cAlias,nReg,nOpc)
	
		if nOpcao == 1 		
			MsgInfo("Inclusão efetuada com sucesso!")
		Else
			MsgAlert("Inclusão cancelada!")
		EndIf
		
Return

/*----------------------------------------------------------------------
	FUNCAO BAltera - Alterar
----------------------------------------------------------------------*/
User Function BAltera(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxAltera(cAlias,nReg,nOpc)
	
		if nOpcao == 1 		
			MsgInfo("Alteração efetuada com sucesso!")
		Else
			MsgAlert("Alteração cancelada!")
		EndIf
		
Return

/*----------------------------------------------------------------------
	FUNCAO BDeleta - Excluir
----------------------------------------------------------------------*/
User Function BDeleta(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxDeleta(cAlias,nReg,nOpc)
	
		if nOpcao == 1 		
			MsgInfo("Exclusão efetuada com sucesso!")
		Else
			MsgAlert("Exclusão cancelada!")
		EndIf
		
Return

/*----------------------------------------------------------------------
	FUNCAO BLegenda - Legenda
----------------------------------------------------------------------*/
User Function BLegenda()
	Local aLegenda := {}
	
	AADD(aLegenda,{"BR_VERDE", 	"Pessoa Fisica",	})
	AADD(aLegenda,{"BR_AMARELO","Pessoa Juridica", 	})
	AADD(aLegenda,{"BR_LARANJA","Exportação", 		})
	AADD(aLegenda,{"BR_MARROM", "Fornecedor Rural", })
	AADD(aLegenda,{"BR_PRETO", 	"Não classificado", })

	BrwLegenda(cCadastro, "Legenda", aLegenda)

Return
