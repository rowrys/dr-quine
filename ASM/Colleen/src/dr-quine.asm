bits 64

global _start


; juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."

section .text
_start:
	; this is a comment
	call _dr_quine
	mov rax, 60
	xor edi, edi
	syscall

_dr_quine:
	ret
