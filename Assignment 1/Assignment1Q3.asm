.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
dwarray dword  0,2,5,9,10
count EQU (LENGTHOF dwarray)
total dword 0

.code
main proc
	mov esi, OFFSET dwarray     ; Set the offset for proper incrementation
    mov ecx, count              ; Set count to the length, count is not technically needed as the
                                ; length could be moved directly into the register
    
	L1:
        mov eax,[esi]			; Move the first val into eax register
        add esi, 4			    ; Inc to get the next value(4 for dwords), and also for the next loop
        mov ebx,[esi]			; Move that value into ebx register
        
        sub ebx, eax			; Get the difference of the two values
        add total, ebx			; Add the difference to the running total      
        Loop L1                 ; At the end, Total = A, or 10
        
	invoke ExitProcess,0
main endp
end main