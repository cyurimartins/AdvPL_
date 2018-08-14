#include 'protheus.ch'
#include 'parmtype.ch'

//PROGRAMA DE ATUALIZAÇÃO


user function MBRW00()

	Local cAlias := "SB1"
	Private cTitulo := "Cadastro Produtos MBROWSE"
	Private aRotina := {}
	
	AADD(aRotina,{"Pesquisa"	, "AxPesqui"	, 0,1})
	AADD(aRotina,{"Visualizar"	, "AxVisual"	, 0,2})
	AADD(aRotina,{"Incluir"		, "AxInclui"	, 0,3})
	AADD(aRotina,{"Alterar"		, "AxAltera"	, 0,4})
	AADD(aRotina,{"Excluir"		, "AxDeleta"	, 0,5})
	AADD(aRotina,{"OlaMundo"	, "U_OLAMUNDO"	, 0,6})

	dbSelectArea(cAlias)
	dbSetOrder(1) //SELECIONANDO O INDICE
	mBrowse(,,,,cAlias)

return Nil
