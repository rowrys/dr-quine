bits 64
default rel
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

section .rodata
	prog db `bits 64\ndefault rel\nglobal _start\n\n%define O_WRONLY 1\n%define O_CREAT 0100\n;\n; %1 => addr\n; %2 => offset\n; %3 => fd\n;\n%macro putChar 3\n\tmov rax, 1\n\tmov rdi, %3\n\tlea rsi, [%1 + %2]\n\tmov rdx, 1\n\tsyscall\n%endmacro\n\nsection .rodata\n\tprog db \`@\`, 0\n\tnewLine db \`\\\\n\`, 0\n\tbacktick db \`\\\\\\\`\`, 0\n\ttab db \`\\\\t\`, 0\n\tdoubleQuote db \`\\\\\"\`, 0\n\tbackSlash db \`\\\\\\\\\`, 0\n\tshellPath db \"/bin/sh\", 0\n\tsully db 5\n\nsection .data\nalign 8\n\tfileName db \"Sully_x.asm\", 0\n\tbinPath db \"/bin/sh\", 0\n\tshellArg db \"-c\", 0\n\tcmd db \"nasm -f elf64 Sully_x.asm -o Sully_x.o && ld Sully_x.o -o Sully_x && ./Sully_x\", 0\n\tstrtab:\n\t\tdq binPath\n\t\tdq shellArg\n\t\tdq cmd\n\t\tdq 0\n\nsection .bss\n\tchar resb 2\n\n; juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\"\n\nsection .text\n_start:\n\tmovzx rcx, byte [sully]\n\ttest rcx, rcx\n\tje .exit\n\tadd cl, '0' - 1\n\tmov byte [fileName + 6], cl\n\tmov byte [cmd + 20], cl\n\tmov byte [cmd + 35], cl\n\tmov byte [cmd + 51], cl\n\tmov byte [cmd + 64], cl\n\tmov byte [cmd + 77], cl\n\tmov rax, 2\n\tlea rdi, fileName\n\tmov rsi, O_WRONLY | O_CREAT\n\tmov rdx, 420\n\tsyscall\n\tmov rdi, rax\n\tmov r14, rax\n\tcmp rax, 0\n\tjl .exit\n\tcall _dr_quine\n\tmov rax, 3\n\tmov rdi, r14\n\tsyscall\n\tmov rax, qword [rsp]\n\tmov rdx, 8\n\tmul rdx\n\tlea rdx, [rsp + rax + 16]\n\tmov rax, 59\n\tmov rdi, shellPath\n\tmov rsi, strtab\n\tsyscall\n\tmov rdi, 1\n.exit:\n\tmov rax, 60\n\tsyscall\n\n_dr_quine:\n\tmov r10, rdi\n\tpush rbx\n\txor rbx, rbx\n.loop:\n\tmovzx rax, byte [prog + rbx]\n\ttest al, al\n\tje .done\n\tcmp al, 64\n\tje .printEscape\n\tcmp al, 4 + 1 + '0'\n\tjne .writeChar\n\tcmp byte [prog + rbx - 2], 'b'\n\tje .sully\n\tjmp .writeChar\n.sully:\n\tmovzx rcx, byte [sully]\n\tadd cl, '0' - 1\n\tmov byte [char], cl\n\tputChar char, 0, r10\n\tjmp .iter\n.printEscape:\n\txor r8, r8\n.printEscapeLoop:\n\tmovzx rax, byte [prog + r8]\n\ttest al, al\n\tje .iter\n\tcmp al, 10\n\tje .newLine\n\tcmp al, 96\n\tje .backtick\n\tcmp al, 9\n\tje .tab\n\tcmp al, 34\n\tje .doubleQuote\n\tcmp al, 92\n\tje .backSlash\n\tputChar prog, r8, r10\n\tjmp .switchEnd\n.newLine:\n\tlea rsi, newLine\n\tjmp .putString\n.backtick:\n\tlea rsi, backtick\n\tjmp .putString\n.tab:\n\tlea rsi, tab\n\tjmp .putString\n.doubleQuote:\n\tlea rsi, doubleQuote\n\tjmp .putString\n.backSlash:\n\tlea rsi, backSlash\n\tjmp .putString\n.putString:\n\tmov rax, 1\n\tmov rdi, r10\n\tmov rdx, 2\n\tsyscall\n.switchEnd:\n\tinc r8\n\tjmp .printEscapeLoop\n.writeChar:\n\tputChar prog, rbx, r10\n.iter:\n\tinc rbx\n\tjmp .loop\n.done:\n\tpop rbx\n\tret`, 0
	newLine db `\\n`, 0
	backtick db `\\\``, 0
	tab db `\\t`, 0
	doubleQuote db `\\"`, 0
	backSlash db `\\\\`, 0
	shellPath db "/bin/sh", 0
	sully db 5

section .data
align 8
	fileName db "Sully_x.asm", 0
	binPath db "/bin/sh", 0
	shellArg db "-c", 0
	cmd db "nasm -f elf64 Sully_x.asm -o Sully_x.o && ld Sully_x.o -o Sully_x && ./Sully_x", 0
	strtab:
		dq binPath
		dq shellArg
		dq cmd
		dq 0

section .bss
	char resb 2

; juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."

section .text
_start:
	movzx rcx, byte [sully]
	test rcx, rcx
	je .exit
	add cl, '0' - 1
	mov byte [fileName + 6], cl
	mov byte [cmd + 20], cl
	mov byte [cmd + 35], cl
	mov byte [cmd + 51], cl
	mov byte [cmd + 64], cl
	mov byte [cmd + 77], cl
	mov rax, 2
	lea rdi, fileName
	mov rsi, O_WRONLY | O_CREAT
	mov rdx, 420
	syscall
	mov rdi, rax
	mov r14, rax
	cmp rax, 0
	jl .exit
	call _dr_quine
	mov rax, 3
	mov rdi, r14
	syscall
	mov rax, qword [rsp]
	mov rdx, 8
	mul rdx
	lea rdx, [rsp + rax + 16]
	mov rax, 59
	mov rdi, shellPath
	mov rsi, strtab
	syscall
	mov rdi, 1
.exit:
	mov rax, 60
	syscall

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
	cmp al, 4 + 1 + '0'
	jne .writeChar
	cmp byte [prog + rbx - 2], 'b'
	je .sully
	jmp .writeChar
.sully:
	movzx rcx, byte [sully]
	add cl, '0' - 1
	mov byte [char], cl
	putChar char, 0, r10
	jmp .iter
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