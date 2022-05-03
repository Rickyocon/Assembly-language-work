INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data?
PINarray BYTE 5 DUP (?)

.data
validStr	BYTE ' is valid PIN', 0dh, 0ah, 0	
invalidStr	BYTE ' is invalid PIN', 0dh, 0ah, 0
rangeTable	BYTE '5'				; set range lookup table mapped to ecx counter 
		DWORD OFFSET digitRange1
rangeSize = ($ - rangeTable)
		BYTE '4'
		DWORD OFFSET digitRange2
		BYTE '3'
		DWORD OFFSET digitRange3
		BYTE '2'
		DWORD OFFSET digitRange4
		BYTE '1'
		DWORD OFFSET digitRange5
tableEntries = ($ - rangeTable) / rangeSize

.code
main proc						
	call Randomize
	mov ecx, 1000
	loopy:
		mov esi, OFFSET PINarray
		mov edi, OFFSET rangeTable
		call genRanPIN			
		call validatePIN
		call writeResult
		sub ecx, 1
		jnz loopy
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

;===================================
; writeResult - print colored valid/invalid string depending on input
; INPUT:	[eax] 1 = invalid, 0 valid
; Returns:	None
;===================================
writeResult proc USES eax
	mov edx, OFFSET PINarray
	call WriteString
	test eax, eax				; check if eax = 0 (valid) or 1 (invalid)
	jnz invalid
	mov eax, 2				; set green text color
	call SetTextColor
	mov edx, OFFSET validStr
	call WriteString
	jmp finish
	invalid:
		mov eax, 4			; set text color to red
		call SetTextColor
		mov edx, OFFSET invalidStr
		call WriteString
	finish:
	mov eax, 15				; restore text to white
	call SetTextColor
	ret
writeResult endp

;===================================
; validatePIN - validates PIN set
; INPUT:	[esi] ptr to array initialised with random digits
;		[edi] range table pointer
; Returns:	[eax] 0=valid, 1=invalid
;===================================
validatePIN proc USES esi ebx ecx
	mov ecx, LENGTHOF PINarray
	digitloop:
		call DWORD PTR [edi+1]		; call function to set N-th digit range
		call validateDigit		; validate digit using supplied range
		test eax, eax
		jnz finish			; eax = 1, invalid digit, exit
		add esi, TYPE PINarray		; move to next random pin
		add edi, rangeSize		; move to next ecx mapped range table 
		sub ecx, 1
		jnz digitloop
	finish:
	ret
validatePIN endp

;====================================
; validateDigit - validates a digit to supplied low/high range
; INPUT: [bl] low range, [bh] high range, [esi] array ptr
; Returns: [eax] 0=valid, 1=invalid
;====================================
validateDigit proc USES ebx esi
	mov al, BYTE PTR [esi]
	cmp al, bl			; check if less than low range
	jl invalid
	cmp al, bh			; check if greater than high range
	jg invalid
	mov eax, 0			; al is bigger than low range, less than high range (valid)
	jmp finish
	invalid:
		mov eax, 1
	finish:
		ret
validateDigit endp

;====================================
; genRan10 - generate random number between 1-9
; INPUT: None
; OUTPUT: [eax] random number 1-9
;====================================
genRan10 proc
	mov eax, 9
	call RandomRange
	add eax, 1
	ret
genRan10 endp

;====================================
; genRanPIN - write 5 random number to suppiled uninitialised array
; INPUT: [esi] ptr to un-init array
; Returns: none, write pin to array
;====================================
genRanPIN proc USES eax ecx esi
	mov esi, OFFSET PINarray
	mov ecx, LENGTHOF PINarray
	pinloop:
		call genRan10
		add al, 48			; convert to ascii letter so it is printable
		mov BYTE PTR[esi], al		; fill the 5 digit array
		add esi, 1
		sub ecx, 1
		jnz pinloop
		ret
genRanPIN endp

;====================================
; digitRange1 - set acceptable range for 1st digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
;====================================
digitRange1 proc
	mov bl, 35h
	mov bh, 39h
	ret
digitRange1 endp

; ====================================
; digitRange2 - set acceptable range for 2nd digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange2 proc
	mov bl, 32h
	mov bh, 35h
	ret
digitRange2 endp

; ====================================
; digitRange3 - set acceptable range for 3rd digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange3 proc
	mov bl, 34h
	mov bh, 38h
	ret
digitRange3 endp

; ====================================
; digitRange4 - set acceptable range for 4th digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange4 proc
	mov bl, 31h
	mov bh, 34h
	ret
digitRange4 endp

; ====================================
; digitRange5 - set acceptable range for 5th digit
; INPUT: None
; Returns: [bh] high range, [bl] low range
; ====================================
digitRange5 proc
	mov bl, 33h
	mov bh, 36h
	ret
digitRange5 endp

end main