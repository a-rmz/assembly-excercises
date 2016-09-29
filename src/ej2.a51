		; 2) Hacer un programa para que el acumulador cuente
		; del 25H al 31H, de uno en uno, se decremente de la misma
		; forma hasta llegar al valor inicial.

		ORG 0000H
		JMP main
		ORG 0040H

main:	MOV A, #25H
		INC A			;26
		INC A			;27
		INC A			;28
		INC A			;29
		INC A			;2A
		INC A			;2B
		INC A			;2C
		INC A			;2D
		INC A			;2E
		INC A			;2F
		INC A			;30
		INC A			;31
		SUBB A, #01		;30
		SUBB A, #01		;2F
		SUBB A, #01		;2E
		SUBB A, #01		;2D
		SUBB A, #01		;2C
		SUBB A, #01		;2B
		SUBB A, #01		;2A
		SUBB A, #01		;29
		SUBB A, #01		;28
		SUBB A, #01		;27
		SUBB A, #01		;26
		SUBB A, #01		;25
		JMP $
		END
		