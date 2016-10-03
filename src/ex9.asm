; ; 9) Hacer un programa para determinar la cantidad de ceros,
; ; de números positivos (aquellos cuyo bit más significativo es cero)
; ; y de números negativos (aquellos cuyo bit más significativo es uno)
; ; que hay en un bloque de memoria externa.
; ; La dirección inicial del bloque está en las localidades 1940H y 1941H,
; ; la longitud del bloque está en la localidad 1942H. El número de elementos
; ; negativos debe colocarse en la localidad 1943H, el número de ceros en la
; ; 1944H y el número de elementos positivos en la localidad 1945H.
;
;             NEGS EQU R5
;             ZEROS EQU R6
;             POS EQU R7
;             DPS EQU 0A2H
;
;             ORG 00H
;             JMP MAIN
;
;             ORG 40H
; MAIN:       ; LOAD THE FIRST LOCATION
;             MOV DPTR, #1940H
;             MOVX A, @DPTR
;             MOV R1, A
;             INC DPTR
;             MOVX A, @DPTR
;             MOV DPS, #01H
;             MOV DPL, A
;             MOV DPH, R1
;
;             MOV DPS, #00H
;             ; LOAD THE BLOCK LENGTH
;             INC DPTR
;             MOVX A, @DPTR
;             MOV R0, A
;
;             MOV DPS, #01H
; BYTE_LOOP:  MOVX A, @DPTR           ; MOVE TO ACC WHAT IS STORED ON DPTR2
;
;             JNZ NOT_ZERO
;             INC ZEROS
;             JMP CONT                ; IF NUMBER IS ZERO, CONTINUE TO THE NEXT
;
; NOT_ZERO:   JNB ACC.7, PLUS_POS     ; IF 7TH BIT IS 0, JUMPS TO INCREMENT POS,
;             INC NEGS                ; OTHERWISE, INCREASES NEGS
;             SJMP CONT
; PLUS_POS:   INC POS
;
; CONT:       INC DPTR
;             DJNZ R0, BYTE_LOOP
;
;             ; WRITE TO EXT NEGS
;             MOV DPS, #00H
;             INC DPTR
;             MOV A, NEGS
;             MOVX @DPTR, A
;
;             ; WRITE TO EXT ZEROS
;             INC DPTR
;             MOV A, ZEROS
;             MOVX @DPTR, A
;
;             ; WRITE TO EXT POS
;             INC DPTR
;             MOV A, POS
;             MOVX @DPTR, A
;
;             END
;
;
;             ; LOADS TO THE ACC THE NEXT BYTE
; ; BYTE_LOOP:  MOV DPS, #01H           ; USE DPTR2
; ;             MOVX A, @DPTR           ; MOVE TO ACC WHAT IS STORED ON DPTR2
; ;             JNZ NOT_ZERO
; ;             INT ZEROS
; ; NOT_ZERO:   MOV C, A.7
; ;             JNC PLUS_POS            ; IF CARRY IS 0, JUMPS TO INCREMENT POS,
; ;             INC NEGS                ; OTHERWISE, INCREASES NEGS
; ;             SJMP CONT
; ; PLUS_POS:   INC POS
; ; CONT:       INC DPTR
; ;             DJNZ R0, BYTE_LOOP
; ;             RET
;
;
;
; ; COUNT ZEROS IN EACH BYTE
; ; ZERO_CNT:   JNB A.7, PLUS
; ; PLUS:       INC ZEROS
; ;             RL A
; ;             DJNZ R2, ZERO_CNT
; ;             RET
;
; ; ADDS ONE TO THE ZERO COUNT
; ; PLUS:       INC ZEROS
;             ; MOV R3, A
;             ; MOV A, ZEROS
;             ; INC A
;             ; MOV ZEROS, A
;             ; RET
;
; ; PLUS_NEG:   INC NEGS
; ;             ; MOV A, NEGS
; ;             ; INC A
; ;             ; MOV NEGS, A
; ;             RET
; ;
; ; PLUS_POS:   INC POS
; ;             ; MOV A, POS
; ;             ; INC A
; ;             ; MOV POS, A
; ;             RET
; ;
; ;             END
