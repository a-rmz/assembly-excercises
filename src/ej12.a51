		; 12) Hacer un programa que multiplique el contenido
		; binario del registro R0 (<20h) por 7 y guarde el
		; resultado en el registro R1. Hacer en dos versiones,
		; con y sin utilizar la instrucción de multiplicación.
		
		ORG 0000H
		JMP main
		ORG 0040H
		
		; Versión con MUL
/*main:	MOV B, #07H
		MOV A, R0
		MUL AB
		MOV R1, A
		END*/

		; Versión sin MUL
main:	MOV R1, #07H
multi:	ADD A, R0
		DJNZ R1, multi
		MOV R1, A
		END