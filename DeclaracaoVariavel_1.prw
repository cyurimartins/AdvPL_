//Bibliotecas
#Include "Protheus.ch"

//Variáveis Estáticas
Static cTesteSta := ''

/*/{Protheus.doc} zEscopo
Função exemplo de escopo de variáveis
@author Aula AdvPL - Terminal da informação https://www.youtube.com/channel/UCiSSA_yn20tEQdEbfo-yBKw/featured
@since 25/03/2018
@version 1.0
	@example
	u_zEscopo()
/*/

User Function zEscopo()
	Local aArea := GetArea()
	
	//Variáveis Locais
  //Quando cria uma função, as variaveis locais devem sempre declarar primeiro, se declarar após, ocorrerá erro de compilação
	Local nVar01 := 5
	Local nVar02 := 8
	Local nVar03 := 10
	
	//Variáveis Privadas, existem 2 modos de declarar private, uma declarando private antes do nome da variavel ou nao informar
	Private cTst := "Teste Pvt"
	cTst2 := "Teste Pvt2"
	
	//Variáveis públicas, IPC: Importante declarar uma variável public com dois __ (underline) antes
  //IPC: sempre evitar usar variaveis publicas, sempre como ultimo recurso
 	Public __cTeste  := "PROFESSOR"
	Public __cTeste2 := "ALUNO"
	
	//Chamando outra rotina para demonstrar o escopo de variáveis
  //O @ significa passar variável por referencia e sempre altera a variável local
	fEscopo(nVar01, @nVar02)
	
	Alert(nVar02)
	Alert("Public: "+__cTeste + " " + __cTeste2)
	RestArea(aArea)
Return

/*-------------------------------------------------*
 | Função: fEscopo                                 |
 | Autor:  exemplo                           |
 | Data:   25/03/2018                              |
 | Descr.: Função que testa escopo de variáveis    |
 *-------------------------------------------------*/

Static Function fEscopo(nValor1, nValor2, nValor3)
	Local aArea := GetArea()
	
	//Variáveis locais
	Local __cTeste2 := "Teste2"
	
	//Valores Default
	Default nValor1 := 0
	Default nValor2 := 0
	Default nValor3 := 0
	
	//Alterando conteúdo do nValor2
	nValor2 += 10
	
	//Mostrando conteúdo da variável private
	Alert("Private: "+cTst2)
	
	//Setando valor da variável pública para demonstrar como pode ser perigoso a utilização
	__cTeste := "Teste1"
	
	RestArea(aArea)
Return
