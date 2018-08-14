#include 'protheus.ch'
#include 'parmtype.ch'

//PROGRAMA DE ATUALIZAÇÃO


user function MODELO1()

	Local cAlias := "SB1"
	Local cTitulo := "Cadastro - AXCadastro"
	Local cVldExc := ".T." //PERMITIR QUE O USUARIO EXLUA UM ITEM
	Local cVlDalt := ".T." // PERMITIR QUE O USUARIO ALTERE UM ITEM
	
	//CHAMANDO A FUNCAO AXCADASTRO
	AxCadastro(cAlias, cTitulo, cVldExc, cVlDalt)

return Nil
