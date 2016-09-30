; ; 7) Hacer un programa para separar el contenido
; ; del R0 en dos grupos de 4 bits. Guardar el grupo
; ; de los 4 bits más significativos en los 4 bits
; ; menos significativos del registro R1 y los 4 bits
; ; menos significativos en los 4 bits menos
; ; significativos del registro R2. Los 4 bits más
; ; significativos de R1 y R2, deben quedar en cero.
;
;             ORG 00H
;             JMP MAIN
;
;             ORG 40H
; MAIN:       MOV R0, #10100101B  ; -> DEBUG PURPOSES ONLY
;
;             MOV A, R0           ; LOAD A WITH THE VALUE
;             SWAP A              ; SWAP THE NIBBLES
;             ANL A, #00001111B   ; AND THE LOWER NIBBLE
;             MOV R1, A           ; MOVE IT TO R1
;
;             MOV A, R0           ; LOAD A WITH THE VALUE
;                                 ; NO NEED TO SWAP THIS TIME
;             ANL A, #00001111B   ; AND THE LOWER NIBBLE
;             MOV R2, A
;
;             END
