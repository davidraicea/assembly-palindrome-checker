.model small
.stack 100h
.data 
	mesajtrue db 13,10, "Sirul introdus este palindrom.$"
	mesajfalse db 13,10, "Sirul introdus nu este palindrom.$"
	introducere db "Introduceti sirul de caractere: $"
	string db 50 dup(0)
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov dx, offset introducere
	mov ah,09h
	int 21h
	
	mov si, offset string
	mov di, offset string
	mov ah, 01h
	
	citire_sir:
		int 21h
		cmp al, 13
		je oprire_citire
		
		cmp al, 'a'
		jb nu_e_litera_mica
		cmp al, 'z'
		ja nu_e_litera_mica
		sub al, 20h
		
	nu_e_litera_mica:
		cmp al, 08
		jne continua
		dec di
		jmp citire_sir
	continua:
		mov [di], al
		inc di
		jmp citire_sir
	oprire_citire:
		mov al, '$'
		mov [di],al
		dec di
	
	testare_palindrom:
		mov al,[si]
		cmp [di],al
		jne nu_este_palindrom
		inc si
		dec di
		cmp si,di
		jl testare_palindrom
	
	este_palindrom:
		mov ah,09h
		mov dx, offset mesajtrue
		int 21h
		jmp exit
		
	nu_este_palindrom:
		mov ah, 09h
		mov dx, offset mesajfalse
		int 21h
		jmp exit
		
	exit:
		mov ah, 4ch
		int 21h
		
end start