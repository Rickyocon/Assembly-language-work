.data
pText BYTE "You cannot read this because it is encrypted.",0dh, 0ah, 0
pLen = ($ - pText) - 3			; minus 1 for null string, 2 for /r/n
keyX BYTE 'A9Xmv#7'
kxLen = ($ - keyX)

.code
main proc
	xor eax, eax
	mov esi, OFFSET pText
	mov edi, OFFSET keyX
	mov ecx, pLen
	mov ebx, kxLen

	mov edx, esi
	call WriteString
	call xorCrypt
	call WriteString

	call WaitMsg
	INVOKE ExitProcess, 0
main endp

xorCrypt proc USES edx ebx esi edi
begin:
	mov al, BYTE PTR [esi]		; xor pText[0] with keyX[0] and overwrite pText[0] with result
	XOR al, BYTE PTR [edi]		; overwrite OK because xor crypt can be reversed
	mov BYTE PTR [esi], al
	add esi, 1
	add edi, 1
	sub ecx, 1
	test ecx, ecx
	jz finish			; if ecx = 0, we have encrypted all letters in pText. finish.
	sub ebx, 1
	jnz begin			; if ebx != 0, we have not used all letter in key so loop back to beginning
	mov edi, OFFSET keyX		; if ebx = 0, cycle the key again and reset the ebx counter
	mov ebx, kxLen
	jmp begin

finish:
	ret
xorCrypt endp

end main