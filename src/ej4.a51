		; 4) Hacer un programa para sumar el contenido de R4
		; con el contenido de R6 y colocar el resultado en R2
		
		ORG 0000H
		JMP main
		ORG 0040H

main:	MOV A, R4
		ADD A, R6
		MOV R2, A
		END