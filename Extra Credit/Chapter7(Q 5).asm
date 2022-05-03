INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

N = 1000

.data?
soeArray WORD (N/2)+1 DUP(?)			; cut half since fillArray proc skips even number. 

.data

.code
main proc		
	xor eax, eax
	xor ebx, ebx
	mov esi, OFFSET soeArray
	mov ecx, N
	call fillArray
	mov ecx, LENGTHOF soeArray + 1
	loopy:
		sub ecx, 1
		jz fin
		add esi, 2
		mov ax, WORD PTR [esi]
		test ax, ax
		jz loopy			; ax = 3
		mov dx, ax			; ax will get clobbered from nPower2, save to bx
		call nPower2			; ax = 9
		cmp ax, N
		jg fin				; ax^2 > N, means prime factoring complete
		mov ax, dx			; restore ax
		call primeChecker
		jmp loopy
	fin:
		mov esi, OFFSET soeArray			
		call printResult
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

;======================================
; printResult
; INPUT: [esi] array ptr, [bx] index counter
; Returns: None
;======================================
printResult proc USES esi ebx
	mov ecx, LENGTHOF soeArray
	begin:
		mov ax, WORD PTR [esi]
		test ax, ax
		jz skipNext			; if zero skip printing.
		call WriteInt
		call Crlf
	skipNext:
		add esi, 2
		sub cx, 1
		jnz begin
	ret
printResult endp

;======================================
; primeChecker - Need improvement to check if divisible starting from eax*eax
; INPUT: [ax] first element to check, [esi] ptr array, [cx] counter
; Returns: None
;======================================
primeChecker proc USES eax ebx ecx edx esi
	mov bx, ax				; set divisor
	begin:
		add esi, 2					
		mov ax, WORD PTR [esi]
		test ax, ax
		jz notComposite			; current array element = 0, skip checks to next element
		xor dx, dx			; prep for div
		div bx
		test dx, dx			; if number not composite, move on to next element
		jnz notComposite			
		mov WORD PTR [esi], 00h		; if number composite, change to NULL
	notComposite:
		sub ecx, 1
		jnz begin
	ret
primeChecker endp

; ======================================
; nPower2 - N to the power of 2 e.g.N*N, 4 * 4, 5 * 5 etc by addition. (3 * 3 = 3 + 3 + 3, 4 + 4 + 4 + 4 and so on)
; INPUT: [ax] N / base number
; Returns: [ax] result
; ======================================
nPower2 proc USES ebx ecx
	xor bx, bx
	mov cx, ax
	begin :
		add bx, ax		; add 3 to ax 3 times
		sub cx, 1
		jnz begin
		mov ax, bx
	ret
nPower2 endp

;======================================
; Fill array for Sieve of Eratosthenes exercise 
; INPUT: [esi] ptr to array, [ecx] N max range
; Returns: none. Supplied undefined array ptr will be initialised with numbers.
;======================================
fillArray proc USES eax esi ecx
	mov ax, 2
	mov WORD PTR[esi], ax
	loopy:
		test ax, 1		; dont need to fill array with even num other than 2
		jz dontPrintEven
		cmp ax, N		; dont go over max limit N
		jg fin
		add esi, 2
		mov WORD PTR[esi], ax
	dontPrintEven:
		add ax, 1
		sub cx, 1
		jnz loopy
	fin:
	ret
fillArray endp
end main