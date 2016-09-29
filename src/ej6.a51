		; 6) Hacer un programa para que en el acumulador aparezca
		; la siguiente secuencia: 10H-11H-22H-33H-44H-55H-66H-33H-11H-10H
		; y luego se repita el proceso. Se puede utilizar cualquier instrucción, pero NINGUNA repetida.
		ORG 0000H
		JMP main
		ORG 0040H

main:	MOV A, #10H			; 10
		MOV 20H, #11H
		MOV A, 20H			; 11
		ADD A, 20H			; 22
		ADD A, #11H			; 33
		MOV R0, #20H
		ADD A, @R0			; 44
		ORL A, #55H			; 55
		XRL A, #33H			; 66
		RR A				; 33
		ANL A, #11H			; 11
		SUBB A, #01H		; 10
		JMP main
		END