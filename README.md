# Microprocessador - Arquitetura de Computadores

## Especificações
Instruções OBRIGATÓRIAS a serem usadas na sua validação:
 - 'ADD ctes': 'Há ADDI que pode somar com constante',
 - 'ADD ops': 'ADD com dois operandos apenas',
 - 'Acumulador ou não': 'ULA com acumulador',
 - 'Carga de constantes': 'Carrega diretamente com LD sem somar',
 - 'Comparações': 'CMP presente',
   - Nota Thomas: Não salvar operação feita para CMP 
 - 'Flags obrigatórias': ['Overflow', 'Zero', 'Carry'],
 - 'SUB ctes': 'SUB apenas entre registradores',
 - 'SUB ops': 'SUB com dois operandos apenas',
 - 'Saltos': 'Incondicional é absoluto e condicional é relativo',
 - 'Subtração': 'SUB sem borrow',
 - 'Validação -- complicações': 'Indicar, ao final, em debug_bit, se 19563 é ''primo ou não',
 - 'Validação -- final do loop': 'Detecção do MSB setado usando OR'

## Todo's
 - [ ] Refactor control_unity
