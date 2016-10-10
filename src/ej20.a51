		; 20) Se tiene una tabla 1 (bloque de números BCD de dos dígitos, 1 byte) en la memoria RAM.
		; La dirección inicial de la tabla 1 se encuentra en la localidad 18F0H y la dirección final en la
		; localidad 18F2H. Se pide un programa en el cual haga tres cosas:
		; El programa principal deberá agregar un checksum (el complemento a dos de la suma de N bytes en binario,
		; despreciando los acarreos) al final de una tabla 2 (descrita en el inciso "b").
		; La subrutina 1 deberá pasar todos los datos BCD que estén en la tabla 1, a una tabla 2  (que tú crearás
		; y cuya dirección inicial es 1900H), convertidos a BINARIO.
		; Al comenzar la subrutina 1 antes de la conversión, hay que checar si el número a convertir es diferente
		; de cero. Si lo es, entonces convierte el número BCD a BINARIO y escríbelo en la tabla 2. Pero si no lo es,
		; es decir si es cero, llama a una subrutina 2 (anidada dentro de la 1), la cual deberá borrar el cero de la 
		; tabla 1, recorrer la lista y actualizar la longitud de la misma COMPRIMIENDOLA, de tal forma que al final
		; del programa la tabla 1, NO contenga ningún cero.
		; NOTAS:
		;   i) Es necesario que la eliminación de ceros y la conversión de datos sea en paralelo. Por lo anterior, el
		;      programa deberá consistir en un programa principal (el que calcula y escribe el checksum al final de la
		;      tabla dos), una subrutina uno (que convierta los números en la tabla 1 de BCD a BINARIO a escribirse en
		;      la tabla dos) y una subrutina dos (que elimine de la tabla uno los ceros y la comprima).
		;  ii) Se deberá anidar forzosamente la subrutina dos dentro de la uno, es decir, no se puede en un primer
		;      momento eliminar los ceros de la tabla 1 y después convertir, si no que la conversión de BCD a BINARIO
		;      y la compresión de la tabla 1, deben ser en paralelo.
		; iii) Cualquier transferencia de datos entre las subrutinas o el programa principal, sólo se podrá hacer a través
		;      de la pila, NO se vale utilizar ningún registro.
		;  iv) El programa deberá estar codificado a partir de la 1800H.
		;   v) La pila deberá estar en la dirección 3FH
		;  vi) La longitud del bloque no excede de 256 bytes.
		; vii) La tabla 1 puede tener una cadena de varios ceros consecutivos.
		
		DPS EQU 0A2H
		ORG 0000H
		JMP main
		ORG 1800H
			
main:	MOV DPS, #01H
		MOV DPTR, #1900H
		MOV DPS, #00H
		MOV DPTR, #18F0H
		MOVX A, @DPTR
		MOV 20H, A				; 20H DPH de dirección de inicio
		INC DPTR
		MOVX A, @DPTR
		MOV 21H, A				; 21H DPL de dirección de inicio
		INC DPTR
		MOVX A, @DPTR
		MOV 22H, A				; 22H DPH de dirección de fin
		INC DPTR
		MOVX A, @DPTR
		MOV 23H, A				; 23H DPL de dirección de fin
		MOV DPH, 20H
		MOV DPL, 21H
		MOV SP, #3FH
		MOV 27H, #00H
ciclo:	MOV DPS, #00H
		MOVX A, @DPTR
		MOV 24H, A
		PUSH 24H
		PUSH 20H
		PUSH 21H
		PUSH 22H
		PUSH 23H
		ACALL tab_2
		POP 24H
		MOV A, 24H
		ADD A, 27H
		MOV 27H, A
		INC DPTR
		MOV A, DPL
		CJNE A, 23H, ciclo
		MOV A, DPH
		CJNE A, 22H, ciclo
		MOV A, 27H
		CPL A
		ADD A, #01H
		MOV DPS, #01H
		MOVX @DPTR, A
		JMP $

tab_2:	POP 25H
		POP 26H
		POP 23H
		POP 22H
		POP 21H
		POP 20H
		POP 24H
		MOV A, 24H
		CJNE A, #00H, bcdbin
		PUSH 24H
		PUSH 20H
		PUSH 21H
		PUSH 22H
		PUSH 23H
		PUSH 26H
		PUSH 25H
		ACALL cmprm
		POP 25H
		POP 26H
		POP 23H
		POP 22H
		POP 21H
		POP 20H
		POP 24H
		MOV A, 24H
		JMP bcdbin		
tab_2r:	MOV DPS, #01H
		MOVX @DPTR, A
		INC DPTR
		MOV 24H, A
		PUSH 24H
		PUSH 26H
		PUSH 25H
		MOV DPS, #00H
		RET

bcdbin:	MOV R0, #00H
		MOV R1, #02H
		MOV R2, A
bcdcic:	MOV A, R2
		ANL A, #0F0H
		SWAP A
		MOV R3, A
		MOV A, R2
		ANL A, #0FH
		SWAP A
		MOV R2, A
		MOV A, R0
		MOV B, #0AH
		MUL AB
		ADD A, R3
		MOV R0, A
		DJNZ R1, bcdcic
		JMP tab_2r
		
		
cmprm:	POP 28H
		POP 29H
		POP 25H
		POP 26H
		POP 23H
		POP 22H
		POP 21H
		POP 20H
		POP 24H
		MOV DPS, #00H
		SETB RS0				; Cambiar a banco de registros 1
		MOV R0, DPH
		MOV R1, DPL
		MOV R2, #02H
		MOV R7, #00H
		MOV DPH, 20H
		MOV DPL, 21H
		MOV R5, #1AH
		MOV R6, #01H
cicmp:	MOVX A, @DPTR
		CJNE A, #00H, cmp
		INC DPTR
		MOV A, DPH
		CJNE A, 22H, val
		MOV A, DPL
		CJNE A, 21H, val
rt:		DJNZ R2, cicmp
		MOV 22H, R3
		MOV 23H, R4
		JMP cop
rt1:	MOVX A, @DPTR
		MOV 24H, A
		CLR RS0					; Cambiar a banco de registros 0
		MOV DPH, R0
		MOV DPL, R1
		PUSH 24H
		PUSH 20H
		PUSH 21H
		PUSH 22H
		PUSH 23H
		PUSH 26H
		PUSH 25H
		PUSH 29H
		PUSH 28H
		RET
		
cmp:	MOV R3, DPH
		MOV R4, DPL
		MOV DPH, R5
		MOV DPL, R6
		MOVX @DPTR, A
		INC DPTR
		MOV R5, DPH
		MOV R6, DPL
		MOV DPH, R3
		MOV DPL, R4
		INC DPTR
		INC R7
		JMP cicmp
		
val:	JC cicmp
		JMP rt
		
cop:	MOV 22H, DPH
		MOV 23H, DPL
		MOV R2, #1AH
		MOV R3, #01H
		MOV R4, 20H
		MOV R5, 21H
		INC R7
ciccop:	MOV DPH, R2
		MOV DPL, R3
		MOVX A, @DPTR
		INC DPTR
		MOV DPH, R4
		MOV DPL, R5
		MOVX @DPTR, A
		INC DPTR
		DJNZ R7, ciccop
		JMP rt1
		END