		; 10) Hacer un programa que calcule la suma
		; de los N primeros n�meros pares. El rango de
		; N es de 1 a 15. El n�mero N se encuentra en
		; el registro R0. El resultado debe guardarse en R1.
		
		ORG 0000H
		JMP main
		ORG 0040H
		
main:	MOV B, R0
		MOV A, R0
		INC A
		MUL AB
		MOV R1, A
		END