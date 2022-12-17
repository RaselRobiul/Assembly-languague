;Binary to hexa           

.MODEL SMALL
.DATA                                           
M1 DB 0AH,0DH,'TYPE A BINARY DIGIT UPTO 16 BIT: ','$'
M2 DB 0AH,0DH,'IN HEXA: ','$'

.CODE
MAIN PROC
    MOV AX, @DATA    ;INITIAL DS
    MOV DS,AX
    
    MOV AH,9
    LEA DX,M1
    INT 21H
    
    ;----------------
    
    MOV BX,0
    MOV AH,1
    MOV CX, 16 
    
 L1: 
    INT 21H
    CMP AL,0DH
    JE OUT_
    
    AND AL,01H
    SHL BX,1
    OR BL,AL
    LOOP L1
    
 OUT_:
    MOV AH,9
    LEA DX,M2
    INT 21H
    
    MOV DH,4
 
 L2:
    MOV CL,4
    MOV DL,BH
    SHR DL,CL
    MOV AH,2
    
    CMP DL,9
    JG LETTER
    ADD DL, 30H
    INT 21H
    JMP L3
    
 LETTER:
    ADD DL,37H
    INT 21H
    ROL BX,CL
    
 L3:
    DEC DH
    CMP DH,0
    JNE L2
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
 