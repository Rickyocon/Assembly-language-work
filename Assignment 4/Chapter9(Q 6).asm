.data

testString BYTE "ABBCCC",0 
freqTable DWORD 256 DUP(0)  

Get_frequencies PROC uses edi tString, fTable
mov eax,0
mov edi,fTable 
mov ecx,256    
rep stosd        
mov edi,fTable
mov edx,tString
mov ecx,SIZEOF tString ;set counter to number of elements in tString

L1:
mov al,  
inc edx    
inc dword ptr 
Loop L1
ret
Get_frequencies ENDP

main proc
INVOKE Get_frequencies, ADDR testString, ADDR freqTable
exit
main endp


