		; 18) Hacer un programa para unir dos listas ordenadas ascendentemente
		; en una sola lista ordenada de la misma forma. El registro DPTR contiene
		; la dirección de la localidad de memoria donde está almacenado el número
		; de elementos de la lista 1, y la lista 1 comienza en la siguiente localidad.
		; Para la lista 2 sucede algo similar, pero con los registros R6 y R7. Los registros
		; R4y R5 contienen la dirección en donde debe comenzar la lista resultante.
		
		DPS EQU 0A2H
		ORG 0000H
		JMP main
		ORG 0040H

main:	MOV DPS, #00H
		MOVX A, @DPTR
		INC DPTR
		MOV R0, A			; R0 tiene le cuenta total
		MOV R1, A			; R1 tiene la cuenta de la primera lista
		MOV DPS, #01H
		MOV DPH, R6
		MOV DPL, R7
		MOVX A, @DPTR
		INC DPTR
		MOV R2, A			; R2 tiene la cuenta de la segunda lista
		ADD A, R0
		MOV R0, A
ciclo1:	MOV DPS, #00H
		MOVX A, @DPTR
		MOV B, A
		MOV DPS, #01H
		MOVX A, @DPTR
		XCH A, B
		CJNE A, B, diff
ciclo:	DJNZ R0, ciclo1
		JMP fin
		
diff:	JC amin1
		MOV A, R2
		JZ bmin1
		MOV DPS, #01H
		MOV R6, DPH
		MOV R7, DPL
		MOV DPH, R4
		MOV DPL, R5
		MOV A, B
		MOVX @DPTR, A
		INC DPTR
		MOV R4, DPH
		MOV R5, DPL
		MOV DPH, R6
		MOV DPL, R7
		INC DPTR
		DEC R2
		JMP ciclo

amin1:	MOV A, R1
		JZ amin2
		MOV DPS, #00H
		MOVX A, @DPTR
		INC DPTR
		MOV DPS, #01H
		MOV R6, DPH
		MOV R7, DPL
		MOV DPH, R4
		MOV DPL, R5
		MOVX @DPTR, A
		INC DPTR
		MOV R4, DPH
		MOV R5, DPL
		MOV DPH, R6
		MOV DPL, R7
		DEC R1
		JMP ciclo
		
amin2:	MOV DPS, #01H
		MOVX A, @DPTR
		INC DPTR
		MOV R6, DPH
		MOV R7, DPL
		MOV DPH, R4
		MOV DPL, R5
		MOVX @DPTR, A
		INC DPTR
		MOV R4, DPH
		MOV R5, DPL
		MOV DPH, R6
		MOV DPL, R7
		DJNZ R2, amin2
		JMP fin

bmin1:	MOV DPS, #01H
		MOVX A, @DPTR
		MOV R6, DPH
		MOV R7, DPL
		MOV DPH, R4
		MOV DPL, R5
		MOVX @DPTR, A
		INC DPTR
		MOV R4, DPH
		MOV R5, DPL
		MOV DPH, R6
		MOV DPL, R7
		INC DPTR
		DJNZ R1, bmin1
		JMP fin
		
fin: 	JMP $
		END
		