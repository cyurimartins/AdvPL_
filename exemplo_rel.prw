#include "rwmake.ch"
#include "topconn.ch"

/////////////////////////////////////////////////////////////////////////////////
// Funcao:    	CRYS0009.PRW                                                    //
// Autor:     	                                                  		//
// Data:      	                                                      		//
// Descricao: 	Relatório COLABORADORES						//
// ************************************************************************** 	//
// Alteração: 	Atualização para MP12						//
// Data: 	01/02/2018							//
// Responsável: Carlos Yuri                                      		//
/////////////////////////////////////////////////////////////////////////////////

User Function CRYS0009()
	
	//DECLARAÇÃO DE VARIAVEIS
	Private cPerg 		:= PADR("CRYS0009", 10)
	Private aRegs       := {}
	Private _cCatFunc := ''

	// FUNÇÃO PARA CHAMAR PERGUNTAS NA SX1
	ValidPerg(aRegs,cPerg)
	If !Pergunte(cPerg,.T.)
		Return
	Endif*/
	
	// VERIFICA TODA EXTENSÃO DA ENTRADA MV_PAR04, VERIFICANDO CADA CARACTERE ADICIONANDO VIRGULA (,) PARA SEPARAR OS CARACTERES
	// QUANDO ENCONTRAR O CARACTERE ASTERISCO(*) SAI DO LAÇO, ENQUANTO NAO ENCONTRAR ADD CADA CARACTERE A VARIAVEL _cCatFunc
	For n=1 to Len(Alltrim(MV_PAR04)) 
	If SUBSTR(MV_PAR04,n,1) ="*"
		loop
	Else 
		_cCatFunc += "'" + SUBSTR(MV_PAR04,n,1) + "',"
	EndIf
	Next
	//LÊ TODO O CONTEUDO DA VARIAVEL -1 CARACTERE
	_cCatFunc := Substr(_cCatFunc,1,Len(_cCatFunc)-1)	
	
	Private cOptions     :=	"1;0;1;CRYS0009"
	//PASSAGEM DE PARAMETROS NA ORDEM DO CRYSTAL
	Private cParams      := cEmpAnt + ";" + cFilAnt + ";" + ALLTRIM(STR(MV_PAR01)) +";"+ ALLTRIM(STR(MV_PAR02)) +";"+ ALLTRIM(STR(MV_PAR03)) +";"+ _cCatFunc
	Private cRpt         :=	"CRYS0009"
	Private lWaitRun     :=	.T.
	Private lRunOnServer :=	.T.
	Private cFile        :=	"CRYS0009"
	
	//MsgAlert(cTipo)
	//MsgAlert(MV_PAR03)
	//MsgAlert(MV_PAR05)
	
	//CHAMANDO O PROGRAMA CRYS0009()
	//CallCrys(cRpt,cParams,cOptions,lWaitRun)
	CallCrys (cFile,cParams,cOptions,lWaitRun)
	//CallCrys (cFile,,cOptions,,,.T.,)

Return .T.

*------------------------------*
Static Function ValidPerg()
*------------------------------*

	Local _sAlias 	:= Alias()
	Local aRegs 	:= {}
	Local i,j
	Private aRegs 	:= {}

	// CRIA PERGUNTAS NA TABELA SX1
	DbSelectArea("SX1")
	dbSetOrder(1)
	
	//PERGUNTAS NA ORDEM DO CRYSTAL
	AADD(aRegs,{cPerg,"01","Sexo	            ","","","MV_CH1","C",01,0,0,"C",""            ,"MV_PAR01","Masculino"     ,"","","","","Feminino"      ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""})
	AADD(aRegs,{cPerg,"02","Possui dependente   ","","","MV_CH2","C",01,0,0,"C",""            ,"MV_PAR02","Sim"     	  ,"","","","","Não"      	   ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""})
	AADD(aRegs,{cPerg,"03","Afastado	     	","","","MV_CH3","C",01,0,0,"C",""            ,"MV_PAR03","Sim"     	  ,"","","","","Não"      	   ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""}) 
	AADD(aRegs,{cPerg,"04","Categoria	     	","","","MV_CH4","C",15,0,0,"G","fCategoria()","MV_PAR04",""       	      ,"","","","",""        	   ,"","","","",""     ,"","","","","" ,"","","","","","","","",""   ,"",""})

	
	For i:=1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
			For j:=1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif
	Next

	DbSelectArea(_sAlias)

Return(.T.)
