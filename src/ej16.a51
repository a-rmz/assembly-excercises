		; 16) Hacer un programa que justifique una fracción binaria de 16 bits
		; que se encuentra en las localidades 1C00H y 1C01H desplazando el número
		; hacia la izquierda hasta que el bit más significativo sea 1. Guardar el
		; resultado en las direcciones 1C02H y 1C03H y el número de desplazamientos
		; en la dirección 1C04H. Si el contendido de las direcciones 1C00H y 1C01H es
		; cero, entonces escribir ceros en las direcciones 1C02H, 1C03H y 1C04H. Este
		; proceso se utiliza para convertir un número a notación científica.
		
		ORG 0000H
		JMP main
		ORG 0040H
		
main:	MOV DPTR, #1C00H
		MOVX A, @DPTR
		MOV R0, A
		MOV DPTR, #1C01H
		MOVX A, @DPTR
		MOV R1, A
		;ANL A, 0FFH
		JZ cero1
cont:	MOV R3, #00H
ciclo:	MOV A, R0
		JB 0E7H, guard
		MOV A, R1
		JB 0E7H, guard
		MOV A, R0
		RL A
		MOV R0, A
		MOV A, R1
		RL A
		MOV R1, A
		INC R3
		JMP ciclo
		
guard:	MOV A, R0
		MOV DPTR, #1C02H
		MOVX @DPTR, A
		MOV A, R1
		MOV DPTR, #1C03H
		MOVX @DPTR, A
		MOV A, R3
		MOV DPTR, #1C04H
		MOVX @DPTR, A
fin:	JMP $
		
cero1:	MOV A, R1
		;ANL A, 0FFH
		JZ cero2
		JMP cont
		
cero2:	MOV A, #00H
		MOV DPTR, #1C02H
		MOVX @DPTR, A
		MOV DPTR, #1C03H
		MOVX @DPTR, A
		MOV DPTR, #1C04H
		MOVX @DPTR, A
		JMP fin
		END
		