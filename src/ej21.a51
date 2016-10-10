		; 21) Implementa un programa que haga la suma y multiplicación de dos matrices. Los datos de entrada son:
		;   i)	# de renglones de A -> 1000H de RAM
		;  ii)	# de columnas de A  -> 1001H de RAM
		; iii)	# de renglones de B -> 1002H de RAM
		;  iv)	# de columnas de B  -> 1003H de RAM
		; •	A partir de la localidad 2000H de RAM se encuentra la matriz A: a11, a12, .., a1n, a21, a22, .., amn.
		; •	A partir de la localidad 3000H de RAM se encuentra la matriz B: b11, b12, .., b1n, b21, b22, .., bmn.
		; Se espera que la suma de matrices se encuentre a partir de la localidad 4000H de RAM y la multiplicación
		; de matrices a partir de la localidad 5000H de RAM.
		; Los datos son de 8 bits con signo.
		
		DPS EQU 0A2H
		REA	EQU 30H 
		COA EQU 31H
		REB EQU 32H
		COB EQU 33H
		ORG 0000H
		JMP main
		ORG 0040H
		
main:	MOV DPS, #00H
		MOV DPTR, #1000H
		MOVX A, @DPTR
		MOV REA, A
		INC DPTR
		MOVX A, @DPTR
		MOV COA, A
		INC DPTR
		MOVX A, @DPTR
		MOV REB, A
		INC DPTR
		MOVX A, @DPTR
		MOV COB, A
		MOV DPTR, #2000H
		MOV DPS, #01H
		MOV DPTR, #3000H
		MOV R0, COA
		MOV R1, REA
		MOV R4, #40H
		MOV R5, #00H
sum:	MOV DPS, #00H
		MOVX A, @DPTR
		INC DPTR
		MOV B, A
		MOV DPS, #01H
		MOVX A, @DPTR
		INC DPTR
		ADD A, B
		MOV R2, DPH
		MOV R3, DPL
		MOV DPH, R4
		MOV DPL, R5
		MOVX @DPTR, A
		INC DPTR
		MOV R4, DPH
		MOV R5, DPL
		MOV DPH, R2
		MOV DPL, R3
		DJNZ R0, sum
		MOV R0, COA
		DJNZ R1, sum
				
		MOV R5, #00H
		MOV R6, #00H
		MOV R7, #00H
		
mul1:	MOV DPH, #50H
		MOV A, R5
		MOV B, COA
		MUL AB
		ADD A, R6
		MOV DPL, A
		MOVX A, @DPTR
		MOV R1, A
		
		MOV DPH, #20H
		MOV A, R5
		MOV B, COA
		MUL AB
		ADD A, R7
		MOV DPL, A
		MOVX A, @DPTR
		MOV R2, A
		
		MOV DPH, #30H
		MOV A, R7
		MOV B, COB
		MUL AB
		ADD A, R6
		MOV DPL, A
		MOVX A, @DPTR
		MOV R3, A
		
		MOV DPH, #50H
		MOV A, R5
		MOV B, COA
		MUL AB
		ADD A, R6
		MOV DPL, A
		
		MOV A, R2
		MOV B, R3
		MUL AB
		ADD A, R1
		MOVX @DPTR, A
		
		INC R7
		MOV A, R7
		CJNE A, COA, mul1
		
		INC R6
		MOV A, R6
		MOV R7, #00H
		CJNE A, COB, mul1
		
		MOV R6, #00H
		INC R5
		MOV A, R5
		CJNE A, REA, mul1
		
		JMP $
		END