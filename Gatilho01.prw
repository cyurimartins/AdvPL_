#include "PROTHEUS.CH"
#include "rwmake.ch"
#include "topconn.ch"

User Function teste() 
	
	//SING001
	c_codRet:=space(4)
	cTeste :=space(4)

	If alltrim(M->E2_NATUREZ) <> ''		
		
		MsgAlert("Possui E2_NATUREZ " + M->E2_NATUREZ)
		
		If alltrim(SED->ED_MSBLQL) == "1"
			//alert("A natureza cadastrada no fornecedor está bloqueada " + SED->ED_MSBLQL)
			Return
		Else
		  	//alert("NATUREZA DISPONIVEL " + SED->ED_MSBLQL)
		  	
		  	If alltrim(SED->ED_CALCIRF) == "S" 	
		  		//alert("Calcula IRF " + SED->ED_CALCIRF)
		  		
		  		if alltrim(SED->ED_XCODRET) <> ""
		  			//alert("Possui XCODRET " + SED->ED_XCODRET)
		  			M->E2_CODRET := SED->ED_XCODRET
		  		Else
		  			M->E2_CODRET:=""
		  			//While alltrim(M->E2_CODRET) == ""
			  			//alert("XCODRET VAZIO, solicitar código retenção ")
			  			M->E2_CODRET:= NewSource()				  				  			 			  			
		  			//End
		  			//M->E2_DIRF:= '1'
		  		Endif
		  	Else
		  		//alert("Não Calcula IRF " + SED->ED_CALCIRF)
		  	Endif
		Endif
	Else 		
		//alert("Esse registro não possui E2_NATUREZ ")		
	Endif		

Return(SA2->A2_NATUREZ)

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function NewSource()

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
//oGet1      := TGet():New( 044,044,{|u| If(PCount()>0,_cCodret:=u,_cCodret)},oDlg1,060,008,'',{ || IF (ExistCpo("SX5", xFilial("SX5")+"37"+_cCodRet+space(2), 1),.T.,.F.) },CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"37","",,)
//oGet1      := TGet():New( 044,044,{|u| If(PCount()>0,_cCodret:=u,_cCodret)},oDlg1,060,008,'',{ || ValidaCodRet(_cCodret) },CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"37","",,)
oGet1      := TGet():New( 044,044,{|u| If(PCount()>0,_cCodret:=u,_cCodret)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"37","",,)
//oBtn1      := TButton():New( 068,056,"OK",oDlg1,{ || M->E2_CODRET:=_cCodret,M->E2_DIRF:= '1',oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn1      := TButton():New( 068,056,"OK",oDlg1,{ || oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.,{|| teste1()})

Return (_cCodret)

Static Function ValidaCodRet(CodRet)

	Local lret := .T.
	
	If !ExistCpo("SX5", xFilial("SX5")+"37"+CodRet+space(2), 1)
		alert("Não existe o registro na SX5")		
	Else 
		//alert("Existe registro")
		lret := .F.		
	EndIf

Return (lret)

Static Function teste1(CodRet)
	
	Local lret := .T.

	If !ExistCpo("SX5","37"+ "CodRet")
		MsgAlert("Não existe este registro cadastrado")
		lret := .F.
	Else
		MsgAlert("existe o resgistro na SX5")	
		M->E2_CODRET:=_cCodret
		M->E2_DIRF:= '1'	
	EndIf
	
Return(lret)
