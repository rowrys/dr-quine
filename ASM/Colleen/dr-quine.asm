bits 64

global _start

;
; %1 => idx
;
%macro putChar 1
	mov rax, 1
	mov rdi, 1
	lea rsi, [prog + %1]
	mov rdx, 1
	syscall
%endmacro

;
; %1 => str
; %2 => len
;
%macro putStr 2
	mov rax, 1
	mov rdi, 1
	lea rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .rodata
	prog db `@`, 0

; juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."

section .text
_start:
	; this is a comment
	call _dr_quine
	mov rax, 60
	xor edi, edi
	syscall

_dr_quine:
	push rbx
	xor rbx, rbx
.loop:
	movzx rax, byte [prog + rbx]
	test al, al
	je .done

	cmp al, 64
	je .printEscape
	jmp .writeChar
.printEscape:
	xor r8, r8
.printEscapeLoop:
	movzx rax, byte [prog + r8]
	test al, al
	je .iter

	cmp al, 10
	je .newLine
	cmp al, 44
	je .backtick
	putChar r8
.newLine:
	putStr `\\n`, 2
.backtick
	putStr `\``, 1

	inc r8
	jmp .printEscapeLoop
.writeChar:
	putChar rbx
.iter:
	inc rbx
	jmp .loop
.done:
	pop rbx
	ret
