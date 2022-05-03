INCLUDE Irvine32.inc

CountNearMatches PROTO, ptrArray1:PTR SDWORD, ptrArray2:PTR SDWORD, szArray:DWORD, diff:DWORD

    .data
    array1a SDWORD 1,2,3,4,5,6,7,8
    array1b SDWORD 5,7,8,7,5,75,43,4
    array2a SDWORD 5,44,7,65,8,7,23,4
    array2b SDWORD 8,2,5,46,55,65,35,4
    cnt DWORD ?,0
    dif1 DWORD 11
    dif2 DWORD 0

    .code
    main PROC		
            INVOKE CountNearMatches, ADDR array1a, ADDR array1b, LENGTHOF array1a, dif1
            call WriteInt
            call Crlf
            INVOKE CountNearMatches, ADDR array2a, ADDR array2b, LENGTHOF array2a, dif2
            call WriteInt
            call Crlf
            exit
            main ENDP

    CountNearMatches PROC USES edx ebx edi esi ecx, ptrArray1:PTR SDWORD, ptrArray2:PTR SDWORD, szArray:DWORD, diff:DWORD
            mov esi,ptrArray1
            mov edi,ptrArray2
            mov ecx,szArray
; Loop
    L1:
; compare sets
    mov ebx,0
    mov ebx,[esi]
    mov edx,0
    mov edx,[edi]
    .IF ebx > edx
            mov eax,ebx
            sub eax,edx
    .ELSE
            mov eax,edx
            sub eax,ebx
    .ENDIF
    .IF (eax <= diff)
            inc cnt
    .ENDIF
    add esi, SIZEOF SDWORD
    add edi, SIZEOF SDWORD
    loop L1
; increment count
    mov eax,0
    mov eax,cnt
    mov cnt,0
    ret
    CountNearMatches ENDP
    END main