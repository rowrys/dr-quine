bits 64

global _start

;
; %1 => addr
; %2 => offset
;
%macro putChar 2
	mov rax, 1
	mov rdi, 1
	lea rsi, [%1 + %2]
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
	prog db `bits 64\n\nglobal _start\n\n;\n; %1 => addr\n; %2 => offset\n;\n%macro putChar 2\n\tmov rax, 1\n\tmov rdi, 1\n\tlea rsi, [%1 + %2]\n\tmov rdx, 1\n\tsyscall\n%endmacro\n\n;\n; %1 => str\n; %2 => len\n;\n%macro putStr 2\n\tmov rax, 1\n\tmov rdi, 1\n\tlea rsi, %1\n\tmov rdx, %2\n\tsyscall\n%endmacro\n\nsection .rodata\n\tprog db \`@\`, 0\n\tnewLine db \`\\\\n\`, 0\n\tbacktick db \`\\\\\\\`\`, 0\n\ttab db \`\\\\t\`, 0\n\tdoubleQuote db \`\\\\\"\`, 0\n\tbackSlash db \`\\\\\\\\\`, 0\n\n; juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\"\n\nsection .text\n_start:\n\t; this is a comment\n\tcall _dr_quine\n\tmov rax, 60\n\txor edi, edi\n\tsyscall\n\n_dr_quine:\n\tpush rbx\n\txor rbx, rbx\n.loop:\n\tmovzx rax, byte [prog + rbx]\n\ttest al, al\n\tje .done\n\tcmp al, 64\n\tje .printEscape\n\tjmp .writeChar\n.printEscape:\n\txor r8, r8\n.printEscapeLoop:\n\tmovzx rax, byte [prog + r8]\n\ttest al, al\n\tje .iter\n\tcmp al, 10\n\tje .newLine\n\tcmp al, 96\n\tje .backtick\n\tcmp al, 9\n\tje .tab\n\tcmp al, 34\n\tje .doubleQuote\n\tcmp al, 92\n\tje .backSlash\n\tputChar prog, r8\n\tjmp .switchEnd\n.newLine:\n\tputStr newLine, 2\n\tjmp .switchEnd\n.backtick:\n\tputStr backtick, 2\n\tjmp .switchEnd\n.tab:\n\tputStr tab, 2\n\tjmp .switchEnd\n.doubleQuote:\n\tputStr doubleQuote, 2\n\tjmp .switchEnd\n.backSlash:\n\tputStr backSlash, 2\n\tjmp .switchEnd\n.switchEnd:\n\tinc r8\n\tjmp .printEscapeLoop\n.writeChar:\n\tputChar prog, rbx\n.iter:\n\tinc rbx\n\tjmp .loop\n.done:\n\tpop rbx\n\tret\n`, 0
	newLine db `\\n`, 0
	backtick db `\\\``, 0
	tab db `\\t`, 0
	doubleQuote db `\\"`, 0
	backSlash db `\\\\`, 0

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
	cmp al, 96
	je .backtick
	cmp al, 9
	je .tab
	cmp al, 34
	je .doubleQuote
	cmp al, 92
	je .backSlash
	putChar prog, r8
	jmp .switchEnd
.newLine:
	putStr newLine, 2
	jmp .switchEnd
.backtick:
	putStr backtick, 2
	jmp .switchEnd
.tab:
	putStr tab, 2
	jmp .switchEnd
.doubleQuote:
	putStr doubleQuote, 2
	jmp .switchEnd
.backSlash:
	putStr backSlash, 2
	jmp .switchEnd
.switchEnd:
	inc r8
	jmp .printEscapeLoop
.writeChar:
	putChar prog, rbx
.iter:
	inc rbx
	jmp .loop
.done:
	pop rbx
	ret
