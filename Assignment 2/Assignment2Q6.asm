INCLUDE Irvine32.inc
strLen=10
.data
arr BYTE strLen DUP(?)

.code
    main PROC
        call Clrscr
        mov esi, offset arr
        mov ecx, 20
        L1:
            call GenerateRandomString
        Loop L1
        call WaitMsg
        exit
    main ENDP

    GenerateRandomString PROC USES ecx  
        mov ecx, lengthOf arr
        L2:
            mov eax, 26
            call RandomRange
            add eax, 65
            mov [esi], eax
            call WriteChar        ; write character
        loop L2      
        call Crlf
        ret
    GenerateRandomString ENDP

END main