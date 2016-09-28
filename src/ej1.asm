            ORG 00H
            JMP MAIN

            ORG 40H
MAIN:       MOV A, #0FH
            MOV R0, #12H
            MOV R1, #34H
            MOV R2, #56H
            MOV R3, #78H
            MOV R4, #09H
            MOV R5, A

            END
