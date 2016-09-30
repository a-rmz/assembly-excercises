		; 8) Hacer un programa para combinar los 4 bits menos
		; significativos del registro R2 y los 4 bits menos significativos
		; del registro R1 en una sola localidad de 8 bits y guardarla en el
		; registro R0. Los 4 bits menos significativos de R2 deberán ocupar
		; los 4 bits menos significativos de R0.
		
		ORG 0000H
		JMP main
		ORG 0040H
		
main:	MOV A, R2
		ANL A, #0FH
		MOV R0, A
		MOV A, R1
		ANL A, #0FH
		RL A
		RL A
		RL A
		RL A
		ORL A, R0
		MOV R0, A
		END