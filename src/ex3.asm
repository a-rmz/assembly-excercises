; 3) Hacer un programa para que el acumulador
; pase de 0 a 10 de uno en uno y luego se repita el proceso

            ORG 00H
            JMP MAIN

            ORG 40H
MAIN:       MOV A, #00H
            MOV R0, #0AH

CYCLE:      INC A
            DJNZ R0, CYCLE
            JMP MAIN

            END
