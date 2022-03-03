.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
source  BYTE  "This is the source string",0
target  BYTE  SIZEOF source DUP('#')

.code
main PROC
	mov  esi,0					; Index register set to the start of the Source
	mov  ecx,SIZEOF source		; Loop counter set the the size of the Source, or end of the string
L1:
	mov  al,source[ecx]			; Get a character from source, starting at the end
	mov  target[esi],al			; Store it in the target, starting at the beginning
	inc  esi					; Move to the next character in the array, inc by 1 btye
	loop L1						; Repeat for entire string

	mov  al,source[ecx]         ; Retrieve the last character
	mov	target[esi],al			; Add the last character to the Target

	Invoke ExitProcess,0
main ENDP
END main