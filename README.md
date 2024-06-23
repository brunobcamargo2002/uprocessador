# Microprocessador - Arquitetura de Computadores

## Especificações
Instruções OBRIGATÓRIAS a serem usadas na sua validação:
 - [x] 'ADD ctes': 'Há ADDI que pode somar com constante',
 - [x] 'ADD ops': 'ADD com dois operandos apenas',
 - [x] 'Acumulador ou não': 'ULA com acumulador',
 - [x] 'Carga de constantes': 'Carrega diretamente com LD sem somar',
 - [x] 'Comparações': 'CMP presente',
    - Nota Thomas: Não salvar operação feita para CMP 
 - [x] 'Flags obrigatórias': ['Overflow', 'Zero', 'Carry'],
 - [x] 'SUB ctes': 'SUB apenas entre registradores',
 - [x] 'SUB ops': 'SUB com dois operandos apenas',
 - [x] 'Saltos': 'Incondicional é absoluto e condicional é relativo',
 - [x] 'Subtração': 'SUB sem borrow',
 - [x] 'Validação -- complicações': 'Indicar, ao final, em debug_bit, se 19563 é ''primo ou não',
 - [x] 'Validação -- final do loop': 'Detecção do MSB setado usando OR'

## Todo's para sexta-feira (28/06)
 - [ ] Descobrir porque não mostra 29 como primo e consertar
 - [ ] Fazer um programa simples mostrando o funcionamento da a instrução JO (Jump overflow)