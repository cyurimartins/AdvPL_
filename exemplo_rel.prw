#include "rwmake.ch"
#include "topconn.ch"

/////////////////////////////////////////////////////////////////////////////////
// Funcao:    CRYS0009.PRW                                                     //
// Autor:                                                        //
// Data:      20/03/2014                                                       //
// Descricao: Relatório COLABORADORES                                          //
/////////////////////////////////////////////////////////////////////////////////

User Function CRYS0009()

	/*Local _cCTT			:= Alltrim(RetSqlName("CTT"))
	Local _cSR8			:= Alltrim(RetSqlName("SR8"))
	Local _cSRA			:= Alltrim(RetSqlName("SRA"))
	Local _cSRB			:= Alltrim(RetSqlName("SRB"))*/
	
	Private cPerg 		:= PADR("CRYS0009", 10)
	Private aRegs       := {}

	// cria perguntas no SX1 

	ValidPerg(aRegs,cPerg)
	If !Pergunte(cPerg,.T.)
		Return
	Endif*/
	
	Private cOptions     :=	"1;0;1;CRYS0009"
	Private cParams      := cEmpAnt + ";" + cFilAnt + ";" + ALLTRIM(STR(MV_PAR01)) +";"+ ALLTRIM(STR(MV_PAR02)) +";"+ ALLTRIM(STR(MV_PAR03)) +";"+ Alltrim(MV_PAR04) /* _cCTT + ";" + _cSR8 + ";" + _cSRA + ";" + _cSRB + ";" + +";"+ CEMPANT +";"+ CFILANT*/
	Private cRpt         :=	"CRYS0009"
	Private lWaitRun     :=	.T.
	Private lRunOnServer :=	.T.
	Private cFile        :=	"CRYS0009"
	
	//MsgAlert(cTipo)
	//MsgAlert(MV_PAR03)
	//MsgAlert(MV_PAR05)

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

	// cria perguntas no SX1

	DbSelectArea("SX1")
	dbSetOrder(1)

	AADD(aRegs,{cPerg,"01","Sexo	            ","","","MV_CH1","C",01,0,0,"C","","MV_PAR01","Masculino"     ,"","","","","Feminino"      ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""})
	AADD(aRegs,{cPerg,"02","Possui dependente   ","","","MV_CH2","C",01,0,0,"C","","MV_PAR02","Sim"     	  ,"","","","","Não"      	   ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""})
	AADD(aRegs,{cPerg,"03","Afastado	     	","","","MV_CH3","C",01,0,0,"C","","MV_PAR03","Sim"     	  ,"","","","","Não"      	   ,"","","","","Todos","","","","","" ,"","","","","","","","",""   ,"",""}) 
	AADD(aRegs,{cPerg,"04","Categoria	     	","","","MV_CH4","C",15,0,0,"G","","MV_PAR04",""       	      ,"","","","",""        	   ,"","","","",""     ,"","","","","" ,"","","","","","","","",""   ,"",""})

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
