INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
prompt BYTE 'This is text colored with White(30%), Green(60%) or Blue(10%) probability.',0dh,0ah,0

.data?

.code
main proc
	call Randomize
	mov ecx, 20

begin:
	call rand10
	cmp eax, 1
	jnz not1
	mov eax, 9				; if eax = 1, set color to white & print text
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin
	jmp finished

not1:
	cmp eax, 5
	jge more5
	jmp less5

less5:						; eax = 2-4, use white(15)
	mov eax, 15
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin
	jmp finished

more5:						; eax= 5 or greater, use green(2)
	mov eax, 2
	call SetTextColor
	call printText
	sub ecx, 1
	jnz begin

finished:
	mov eax, 15				; restore normal text color
	call SetTextColor
	call WaitMsg
	INVOKE ExitProcess, 0
main endp

rand10 proc
	mov eax, 10				; generate random number 1-10
	call RandomRange
	add eax, 1			
	ret
rand10 endp

printText proc USES edx
	mov edx, OFFSET prompt
	call WriteString
	ret
printText endp

end main