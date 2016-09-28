; ; 5) Hacer un programa que sume 10 datos
; ; que están en la RAM interna a partir de
; ; la dirección 30H y guarde el resultado en la dirección 40H.
;
;             RESULT EQU 40H
;
;             ORG 00H
;             JMP MAIN
;
;             ORG 40H
; MAIN:       MOV A, #00H
;             MOV R1, #30H
;             MOV R0, #0AH
;
; CYCLE:      ADD A, @R1
;             INC R1
;             DJNZ R0, CYCLE
;             MOV RESULT, A
;
;             END
