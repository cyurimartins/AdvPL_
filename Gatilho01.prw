#include "PROTHEUS.CH"
#include "rwmake.ch"
#include "topconn.ch"

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/
User Function SING002() 
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/

	c_codRet:=space(4)
	
	//verificar se existe natureza
	If alltrim(M->E2_NATUREZ) <> ''	
		
		//verificar se natureza bloqueada
		If alltrim(SED->ED_MSBLQL) == "1"
			Return
		Else
		
			//verificar se calcula IR
		  	If alltrim(SED->ED_CALCIRF) == "S" 	
		  	
		  		//verificar se possui código de retenção
		  		if alltrim(SED->ED_XCODRET) <> ""
		  			M->E2_CODRET := SED->ED_XCODRET
		  		Else
		  			M->E2_CODRET:=""		  			
			  		M->E2_CODRET:= NewSource()		  			 			  					  		
		  		Endif
		  	Else
		  	
		  	Endif
		Endif
	Else 		
	
	Endif		

Return(SA2->A2_NATUREZ)

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/
Static Function NewSource()
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/

	local _cCodret := space(4)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oDlg1","oSay1","oGet1","oBtn1")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oDlg1      := MSDialog():New( 133,300,375,613,"Protheus",,,.F.,,,,,,.T.,,,.T. )
	oSay1      := TSay():New( 024,040,{||"Digite o código de retenção"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
	oGet1      := TGet():New( 044,044,{|u| If(PCount()>0,_cCodret:=u,_cCodret)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"37","",,)
	oBtn1      := TButton():New( 068,056,"OK",oDlg1,{ || oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.,{|| ValidCodRet(_cCodRet)})
	
Return (_cCodret)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/
Static Function ValidCodRet(_cCodret)
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±*/

	Local lret := .T.
	
	If !ExistCpo("SX5","37"+ _cCodret)
			lret := .F.
		Else
			M->E2_CODRET:=_cCodret
			M->E2_DIRF:= '1'	
	EndIf
	
Return (lret)
