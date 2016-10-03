; ; 11) Hacer un programa para mover el bloque de memoria
; ; que comienza en la dirección 1A00H y termina en
; ; la dirección 1BFFH, a la sección de memoria que comienza
; ; en la 1C00H.
; ; El programa debe terminar cuando se haya transferido
; ; todo el bloque  o cuando se encuentre un dato con valor FFH.
;
;             DPCON EQU 0A2H
;
;             ORG 00H
;             JMP MAIN
;
;             ORG 40H
; MAIN:       MOV DPCON, #01H     ; USE DPTR 2
;             MOV DPTR, #1C00H
;             MOV DPCON, #00H     ; USE DPTR 1
;             MOV DPTR, #1A00H
;
; CYCLE:      MOVX A, @DPTR
;             INC DPTR            ; INCREASE DPTR 1
;             CPL A
;             JZ FINISH
;             CPL A
;             MOV DPCON, #01H     ; USE DPTR 2
;             MOVX @DPTR, A
;             INC DPTR            ; INCREASE DPTR 2
;             MOV DPCON, #00H     ; USE DPTR 1
;             MOV A, DPH
;             CJNE A, #1BH, CYCLE
;
; FINISH:     JMP $
;             END
