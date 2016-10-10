		; 15) Hacer un programa para contar el número de bits con valor 1
		; que hay en un bloque de memoria cuya dirección inicial se encuentra
		; almacenada en las localidades 1A00H y 1A01H y cuya dirección final esta
		; almacenada en las localidades 1A02H y 1A03H. El número total de unos debe
		; guardarse en las localidades 1A04H y 1A05H. Se sugiere  utilizar un lazo para
		; contar los unos dentro de cada localidad del bloque, anidado en otro lazo que se
		; encargue de acumular los unos resultantes de todas las localidades
		
		DPS EQU 0A2H
		ORG 0000H
		JMP main
		ORG 0040H

main:	MOV DPS, #00H
		MOV R0, #00H			; Parte alta cuenta total
		MOV R1, #00H			; Parte baja cuenta total
		MOV R2, #00H			; Cuenta parcial
		MOV DPTR, #1A00H
		MOVX A, @DPTR
		INC DPTR
		MOV R3, A				; R3 tiene el DPH inicio
		MOVX A, @DPTR
		INC DPTR
		MOV R4, A				; R4 tiene el DPL inicio
		MOVX A, @DPTR
		INC DPTR
		MOV R5, A				; R5 tiene DPH fin
		MOVX A, @DPTR
		INC DPTR
		MOV R6, A				; R6 tiene DPL fin
		ADD A, #01H
		MOV 30H, A
		MOV A, R5
		ADDC A, #00H
		MOV 31H, A
		MOV DPS, #01H
		MOV DPH, R3
		MOV DPL, R4
cont_T:	MOVX A, @DPTR
		INC DPTR
		MOV R7, #08H
		MOV R2, #00H
		CLR C
cont_P:	RLC A
		MOV B, A
		CLR A
		MOV A, R2
		ADDC A, #00H
		MOV R2, A
		MOV A, B
		DJNZ R7, cont_P
		MOV A, R1
		ADD A, R2
		MOV R1, A
		MOV A, R0
		ADDC A, #00H
		MOV R0, A
		MOV A, DPH
		CJNE A, 31H, cont_T
		MOV A, DPL
		CJNE A, 30H, cont_T
		MOV DPS, #00H
		MOV A, R0
		MOVX @DPTR, A
		INC DPTR
		MOV A, R1
		MOVX @DPTR, A
		JMP $
		END