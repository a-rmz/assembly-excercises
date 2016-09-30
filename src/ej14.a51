		; 14) Hacer un programa para que ordene una lista de
		; números binarios de 8 bits con signo en orden ascendente
		; (menor a mayor). La longitud de la lista está en la localidad
		; de memoria 1B00H y la lista misma comienza en la localidad de
		; memoria 1B01H. Los números están en complemento a dos.
		
		DPS EQU 0A2H
		ORG 0000H
		JMP main
		ORG 0040H
			
main:	MOV DPS, #00H
		MOV DPTR, #1B00H
		MOVX A, @DPTR
		MOV DPS, #01H
		MOV DPTR, #1B01H
		SUBB A, #01H
		MOV R0, A

orden1:	MOV A, R0
		MOV R1, A
orden2:	MOV DPS, #00H
		INC DPTR
		MOVX A, @DPTR
		MOV R2, A
		MOV DPS, #01H
		INC DPTR
		MOVX A, @DPTR
		MOV R3, A
		MOV 30H, R2
		CJNE A, 30H, diff
orden3:	DJNZ R1, orden2
		DJNZ R0, main

diff:	JC tmayor
		JMP orden3		
		
tmayor:	XCH A, R3
		XCH A, R2
		XCH A, R3
		MOV DPS, #01H
		MOV A, R3
		MOVX @DPTR, A
		MOV DPS, #00H
		MOV A, R2
		MOVX @DPTR, A		
		JMP orden3
		end