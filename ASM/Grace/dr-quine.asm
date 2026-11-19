bits 64

global _start

%define O_WRONLY 1
%define O_CREAT 0100
;
; %1 => addr
; %2 => offset
; %3 => fd
;
%macro putChar 3
	mov rax, 1
	mov rdi, %3
	lea rsi, [%1 + %2]
	mov rdx, 1
	syscall
%endmacro


%macro dr_quine 0
_dr_quine:
	mov r10, rdi
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
	putChar prog, r8, r10
	jmp .switchEnd
.newLine:
	lea rsi, newLine
	jmp .putString
.backtick:
	lea rsi, backtick
	jmp .putString
.tab:
	lea rsi, tab
	jmp .putString
.doubleQuote:
	lea rsi, doubleQuote
	jmp .putString
.backSlash:
	lea rsi, backSlash
	jmp .putString
.putString:
	mov rax, 1
	mov rdi, r10
	mov rdx, 2
	syscall
.switchEnd:
	inc r8
	jmp .printEscapeLoop
.writeChar:
	putChar prog, rbx, r10
.iter:
	inc rbx
	jmp .loop
.done:
	pop rbx
	ret
%endmacro


%macro start 0
_start:
	mov rax, 2
	lea rdi, fileName
	mov rsi, O_WRONLY | O_CREAT
	mov rdx, 420
	syscall
	mov rdi, rax
	mov r15, rax
	cmp rax, 0
	jl .exit
	call _dr_quine
	mov rax, 3
	mov rdi, r15
	syscall
	xor edi, edi
.exit:
	mov rax, 60
	syscall
%endmacro

section .rodata
	prog db `bits 64\n\nglobal _start\n\n%define O_WRONLY 1\n%define O_CREAT 0100\n;\n; %1 => addr\n; %2 => offset\n; %3 => fd\n;\n%macro putChar 3\n\tmov rax, 1\n\tmov rdi, %3\n\tlea rsi, [%1 + %2]\n\tmov rdx, 1\n\tsyscall\n%endmacro\n\n\n%macro dr_quine 0\n_dr_quine:\n\tmov r10, rdi\n\tpush rbx\n\txor rbx, rbx\n.loop:\n\tmovzx rax, byte [prog + rbx]\n\ttest al, al\n\tje .done\n\tcmp al, 64\n\tje .printEscape\n\tjmp .writeChar\n.printEscape:\n\txor r8, r8\n.printEscapeLoop:\n\tmovzx rax, byte [prog + r8]\n\ttest al, al\n\tje .iter\n\tcmp al, 10\n\tje .newLine\n\tcmp al, 96\n\tje .backtick\n\tcmp al, 9\n\tje .tab\n\tcmp al, 34\n\tje .doubleQuote\n\tcmp al, 92\n\tje .backSlash\n\tputChar prog, r8, r10\n\tjmp .switchEnd\n.newLine:\n\tlea rsi, newLine\n\tjmp .putString\n.backtick:\n\tlea rsi, backtick\n\tjmp .putString\n.tab:\n\tlea rsi, tab\n\tjmp .putString\n.doubleQuote:\n\tlea rsi, doubleQuote\n\tjmp .putString\n.backSlash:\n\tlea rsi, backSlash\n\tjmp .putString\n.putString:\n\tmov rax, 1\n\tmov rdi, r10\n\tmov rdx, 2\n\tsyscall\n.switchEnd:\n\tinc r8\n\tjmp .printEscapeLoop\n.writeChar:\n\tputChar prog, rbx, r10\n.iter:\n\tinc rbx\n\tjmp .loop\n.done:\n\tpop rbx\n\tret\n%endmacro\n\n\n%macro start 0\n_start:\n\tmov rax, 2\n\tlea rdi, fileName\n\tmov rsi, O_WRONLY | O_CREAT\n\tmov rdx, 420\n\tsyscall\n\tmov rdi, rax\n\tmov r15, rax\n\tcmp rax, 0\n\tjl .exit\n\tcall _dr_quine\n\tmov rax, 3\n\tmov rdi, r15\n\tsyscall\n\txor edi, edi\n.exit:\n\tmov rax, 60\n\tsyscall\n%endmacro\n\nsection .rodata\n\tprog db \`@\`, 0\n\tnewLine db \`\\\\n\`, 0\n\tbacktick db \`\\\\\\\`\`, 0\n\ttab db \`\\\\t\`, 0\n\tdoubleQuote db \`\\\\\"\`, 0\n\tbackSlash db \`\\\\\\\\\`, 0\n\tfileName db \"Grace_kid.asm\"\n\n; juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\"\n\nsection .text\nstart\n\ndr_quine\n`, 0
	newLine db `\\n`, 0
	backtick db `\\\``, 0
	tab db `\\t`, 0
	doubleQuote db `\\"`, 0
	backSlash db `\\\\`, 0
	fileName db "Grace_kid.asm"

; juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."

section .text
start

dr_quine
