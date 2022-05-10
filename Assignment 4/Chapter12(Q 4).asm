main:
push rbp
mov
rbp, rsp
mov
DWORD PTR [rbp-4], 5
mov
DWORD PTR [rbp-8], 6
mov
WORD PTR [rbp-12],
mov
DWORD PTR [rbp-16], i
mov
DWORD PTR [rbp-20], 9
mov
edx, DWORD PTR [rbp-4]
mov
eax, DWORD PTR [rbp-8]
add
eax, edx
cda
idiv
WORD PTR [rbp-12]
mov
ecx, eax
mov
eax, DWORD PTR [rbp-16]
sub
eax, DWORD PTR [rbp-4]
mov
edx, eax
mov
ex, DWORD PTR [rbp-201
add
eax, edx
imul eax, ecx
pop rbp
ret

