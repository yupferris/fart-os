[bits 16]
[org 7c00h]
jmp 0000:entry
entry:
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov sp, ax
	
reset:
	mov al, 3
	mov ah, 0
	int 10h
	mov si, hello
	call print
	mov si, daveSucks
mainPrompt:
	lodsb
	or al, al
	jnz printTheFuck
		mov si, daveSucks
		jmp mainPrompt
printTheFuck:
	call printChar
	mov ah, 0
	int 16h
	cmp al, 1bh
	jnz mainPrompt
	jmp reset
	
print:
	lodsb
	or al, al
	jz printDone
	call printChar
	jmp print
	
printDone:
	ret
	
printChar:
	cmp al, 0ah
	jne char
		mov al, 0dh
		call printCharInt
		mov al, 0ah
char:
	call printCharInt
	ret
	
printCharInt:
	mov ah, 0eh
	mov bx, 9
	int 10h
	ret

hello:
	db "Fart OS 0.0.1", 0ah, "(C)2013 Jake Taylor", 0ah, 0ah, 0
daveSucks:
	db ">Dave sucks.", 0ah, 0
