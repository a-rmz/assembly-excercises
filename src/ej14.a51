		; 14) Hacer un programa para que ordene una lista de
		; números binarios de 8 bits con signo en orden ascendente
		; (menor a mayor). La longitud de la lista está en la localidad
		; de memoria 1B00H y la lista misma comienza en la localidad de
		; memoria 1B01H. Los números están en complemento a dos.
		
		DPS EQU 0A2H
		ORG 0000H
		JMP main1
		ORG 0040H
			
main1:	MOV DPS, #00H
		MOV DPTR, #1B00H
		MOVX A, @DPTR
		MOV DPS, #01H
		MOV DPTR, #1B01H
		SUBB A, #01H
		MOV R4, A
main:	MOV DPS, #00H
		MOV DPTR, #1B00H
		MOVX A, @DPTR
		MOV DPS, #01H
		MOV DPTR, #1B01H
		SUBB A, #01H
		MOV R0, A

		MOV A, R0
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
		CJNE R0, #00H, orden1
		JMP cont
orden1:	DJNZ R4, main
cont:	MOV DPS, #00H
		MOV DPTR, #1A00H
		MOV DPS, #01H
		MOV DPTR, #1B00H
		MOVX A, @DPTR
		MOV R0, A
		INC DPTR
		MOV R1, #00H
		JMP bruj

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
		
bruj:	MOV DPS, #01H
		MOVX A, @DPTR
		INC	 DPTR
		CJNE A, #80H, check
		JMP neg
brinc:	DJNZ R0, bruj
		JMP pos
		
check:	JNC neg
		JMP brinc
neg:	MOV DPS, #00H
		MOVX @DPTR, A
		INC DPTR
		MOV DPS, #01H
		MOVX A, @DPTR
		INC DPTR
		INC R1
		DJNZ R0, neg
		MOV DPS, #01H
		MOV DPTR, #1B01H
		JMP pos
pos:	MOVX A, @DPTR
		INC DPTR
		MOV DPS, #00H
		MOVX @DPTR, A
		INC DPTR
		MOV DPS, #01H
		DJNZ R1, pos
		MOV DPS, #00H
		MOV DPTR, #1A00H
		MOV DPS, #01H
		MOV DPTR, #1B00H
		MOVX A, @DPTR
		INC DPTR
		MOV R0, A
copy:	MOV DPS, #00H
		MOVX A, @DPTR
		INC DPTR
		MOV DPS, #01H
		MOVX @DPTR, A
		INC DPTR
		DJNZ R0, copy
		JMP $
		end