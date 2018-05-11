#include "rwmake.ch"
#include "topconn.ch"

/////////////////////////////////////////////////////////////////////////////////
// @aut: YuriMartins                                                           //
// Descricao: Relatorio Horas Extras                                           //
/////////////////////////////////////////////////////////////////////////////////

User Function CRYS0033()

	Local aCRYS33			    := {}
	Local _cVerba 			  := ""                        
	
	Private cPerg 			  := PADR("CRYS0033", 10)
	Private aRegs 			  := {}
	Private cOptions    	:= "1;0;1;CRYS0033"
	Private cParams      	:= ""
	Private cRpt         	:= "CRYS0033"
	Private lWaitRun     	:= .T.
	Private lRunOnServer 	:= .T.
	Private cFile        	:= "CRYS0033"

	//CRIA PERGUNTA NA SX1 
	
	ValidPerg(aRegs,cPerg)
	If !Pergunte(cPerg,.T.)
		Return
	Endif

	//Private cSRD := RETSQLNAME ("SRD")
	//Private cSRA := RETSQLNAME ("SRA")
	Private cSRV := RETSQLNAME ("SRV")
	//Private cCTT := RETSQLNAME ("CTT")
	
	_cVerba := "'" + Posicione("SRV",2,xFilial("SRV") + "0035","RV_COD") + "',"

	DbSelectArea("SRV")
	DbSetOrder(1)
	DbGotop()
	
	while !Eof()
		if SRV->RV_HE <> "S" .and. SRV->RV_CODDSR = Space(3)
			DbSkip()
			Loop
		endif
		If SRV->RV_HE = "S"
			_cVerba += "'" + SRV->RV_COD + "',"
		EndIf 
		if SRV->RV_CODDSR <> Space(3) .and. SRV->RV_HE = "S"
			if !SRV->RV_CODDSR $ _cVerba
				_cVerba += "'" + SRV->RV_CODDSR + "',"
			endif
		endif 
		DbSkip()
	enddo

	_cVerba := SubStr(_cVerba,1,Len(Alltrim(_cVerba))-1)
	
	//CRIA UMA ESTRUTURA PARA A TABELA TEMPORARIA
	
	aCRYS33	:= {{"RD_DATARQ"	,"C",06,0},;
				{"RA_MAT"		,"C",06,0},;
				{"RA_NOME"		,"C",30,0},;
				{"RA_CC"	   	,"C",09,0},;
				{"RD_PD"   		,"C",03,0},;
				{"RV_DESC"	   	,"C",20,0},;
				{"RD_HORAS"     ,"N",09,0},;
				{"RD_VALOR"		,"N",12,0}}
	
	//VERIFICA SE TABELA EXISTE			
	If TCCanOpen("CRYS0033")
		_cDelCRY := "DROP TABLE CRYS0033" // ATRIBUI UMA QUERY A VARIAVEL
		If (TCSQLExec(_cDelCRY) < 0) // EXECUTA A QUERY DENTRO DA VARIAVEL
			Return MsgStop("TCSQLError() " + TCSQLError()) //EXIBE UMA MSG DE ERRO
		EndIf
	EndIf 

	//CRIA UMA TABELA COM NOME CRYS0033 E UTILIZA A ESTRUTURA QUE CONTEM DENTRO DO ARRAY, UTILIZA O BANCO DE DADOS TOPCONN
	DbCreate("CRYS0033",aCRYS33,"TOPCONN") 
	dbUseArea(.T., 'TOPCONN', "CRYS0033",'CRYS33', .T., .F.)
	
	//INICIO DO SQL NA VARIAVEL
	_cQrySRA 	:= "SELECT RD_DATARQ, RA_MAT, RA_NOME, RA_CC, RD_PD, RV_DESC, RD_HORAS, RD_VALOR " 
	_cQrySRA	+= "FROM " + RetSqlName("SRD") + " RD "
	_cQrySRA	+= "INNER JOIN " + RetSqlName("SRA") + " RA ON RA.D_E_L_E_T_ = '' AND RA.RA_FILIAL = RD.RD_FILIAL AND RA.RA_MAT = RD.RD_MAT "
	_cQrySRA	+= "INNER JOIN " + RetSqlName("SRV") + " RV ON RV.D_E_L_E_T_ = '' AND RV.RV_COD = RD.RD_PD "
	_cQrySRA	+= "INNER JOIN " + RetSqlName("CTT") + " CTT ON CTT.CTT_CUSTO = RD.RD_CC AND CTT.D_E_L_E_T_ = '' AND RA.RA_FILIAL = CTT.CTT_FILIAL "
	_cQrySRA	+= "WHERE RD.D_E_L_E_T_='' " 
	_cQrySRA	+= "AND RD.RD_PD IN (" +  _cVerba + " ) " 
	_cQrySRA	+= "AND	RD.RD_DATARQ BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 
	_cQrySRA	+= "AND	CTT.CTT_CUSTO BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	
	_cQrySRA := ChangeQuery(_cQrySRA)
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,_cQrySRA),'TRB', .F., .T.)	
	
	// ENQUANTO NAO CHEGAR NO FIM DA TABELA
	While !Eof()	
		DbSelectArea("CRYS33")
		RecLock("CRYS33",.T.)
			CRYS33->RD_DATARQ 	:= TRB->RD_DATARQ
			CRYS33->RA_MAT 		:= TRB->RA_MAT
			CRYS33->RA_NOME 	:= TRB->RA_NOME
			CRYS33->RA_CC		:= TRB->RA_CC
			CRYS33->RD_PD		:= TRB->RD_PD
			CRYS33->RV_DESC		:= TRB->RV_DESC
			CRYS33->RD_HORAS	:= TRB->RD_HORAS
			CRYS53->RD_VALOR	:= TRB->RD_VALOR			
		MsUnLock()
		DbSelectArea("TRB")
		Dbskip()		
	Enddo	
	
	cParams := cEmpAnt +";"+  cFilAnt

	//CallCrys(cRpt,cParams,cOptions,lWaitRun)
	CallCrys (cFile,cParams,cOptions,lWaitRun)
	//CallCrys (cFile,,cOptions,,,.T.,)
Return .T.

	*-------------------------*
Static Function ValidPerg()
	*-------------------------*

	Local _sAlias 	:= Alias()
	Local aRegs 	:= {}
	Local i,j
	Private aRegs	:= {}

	// CRIA PERGUNTAS NA SX1
	DbSelectArea("SX1")
	dbSetOrder(1)

	AADD(aRegs,{cPerg,"01","Ano/Mes Inicial (AAAAMM):"	,"","","MV_CH0","C",6,0,0,"C","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","" ,"","","","","","",""})
	AADD(aRegs,{cPerg,"02","Ano/Mes Final (AAAAMM):"	,"","","MV_CH1","C",6,0,0,"C","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","" ,"","","","","","",""})
	AADD(aRegs,{cPerg,"03","Centro de Custo Inicial:"	,"","","MV_CH2","C",9,0,0,"C","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","" ,"","","","","","",""})
	AADD(aRegs,{cPerg,"04","Centro de Custo Final:"		,"","","MV_CH3","C",9,0,0,"C","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","" ,"","","","","","",""})
	
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

/*
TCCanOpen( < cTable >, [ cIndex ] )
	Verifica se uma tabela e/ou índice existe. 

TCSqlExec( < cStatement > )
	Executa uma sentença de sintaxe SQL (Structured Query Language). 

MSGSTOP( <cTexto>, <cTitulo> ) 
	Mostra uma mensagem de advertência na tela.

TCSqlError()
	Recupera uma string contendo a última ocorrência de erro de execução de statement e/ou operação.

DBCreate( < cName >, < aStruct >, [ cDriver ] )
	Define uma nova tabela ou um novo arquivo do tipo tabela e sua estrutura (campos).

dbUseArea(<expressão lógica 1>, <expressão caracter 1>, <expressão caracter 2>, <expressão caracter 3>, <expressão lógica 2>, <expressão lógica 3>)
	Define um arquivo de dados como uma área de trabalho disponível na aplicação.

ChangeQuery ()
	Esta função tem como objetivo retornar uma query modificada de acordo a escrita adequada para o banco de dados em uso, a partir da query originalmente informada.

TCGenQry( < xPar1 >, < xPar2 >, < cQuery > )
	Permite a abertuda de uma query diretamente no banco de dados utilizado na conexão atual, mediante uso da RDD TOPCONN. O retorno desta função deve ser passado como 3º parâmetro da função DbUseArea, conforme exemplo abaixo.

MSUNLOCK( )
	Libera o travamento (lock) do registro posicionado, desde que o lock não seja feito dentro de um transação. Neste caso, o lock somente será liberado ao termino da mesma.

DBSkip( [ nReg ] )
	Desloca para outro registro na tabela corrente.
*/
