INCLUDE Irvine32.inc

FindThrees PROTO, pArr: PTR BYTE, length: BYTE

.data
strCons BYTE “The array contains three consecutive 3.”,0
strNonCon BYTE “The array does not contain three consecutive 3.”,0
arrOne BYTE 1, 2, 3, 2
arrTwo BYTE 3, 3, 5, 7, 3
arrThree BYTE 4, 3, 3, 3, 1, 8



.code
main PROC

INVOKE FindThrees, ADDR arrOne, LENGTHOF arrOne
.IF eax == 1
mov edx,OFFSET strCons
call WriteString
call Crlf
.ELSE
mov edx,OFFSET strNonCon
call WriteString
call Crlf
.ENDIF
INVOKE FindThrees, ADDR arrTwo, LENGTHOF arrTwo
.IF eax == 1
mov edx,OFFSET strCons
call WriteString
call Crlf
.ELSE
mov edx,OFFSET strNonCon
call WriteString
call Crlf
.ENDIF
INVOKE FindThrees, ADDR arrThree, LENGTHOF arrThree
.IF eax == 1
mov edx,OFFSET strCons
call WriteString
call Crlf
.ELSE
mov edx,OFFSET strNonCon
call WriteString
call Crlf
.ENDIF
exit
main ENDPFindThrees PROC USES esi ecx,
pArr: PTR BYTE, 
length: BYTE 

mov eax,0 
mov esi,pArr 
mov ecx,length
sub ecx,2 
L1:
.IF [esi] == 3
.IF [esi+1] == 3
.IF [esi+2] == 3
mov eax,1 
jmp L2
.ENDIF
.ENDIF
.ENDIF
inc esi 
loop L1
L2:
ret
FindThrees ENDP
END main