#include <stddef.h>
#include <stddef.h>
#include <stdio.h>

const char*	prog = "#include <stddef.h>\n#include <stddef.h>\n#include <stdio.h>\n\nconst char*\tprog = \"@\";\n\nstatic void\ndr_quine(void) {\n\tif (!prog)\n\t\treturn ;\n\tfor (size_t i = 0; prog[i]; i++) {\n\t\tif (prog[i] == 64) {\n\t\t\tfor (size_t j = 0; prog[j]; j++) {\n\t\t\t\tswitch (prog[j]) {\n\t\t\t\t\tcase '\\n':\n\t\t\t\t\t\tprintf(\"\\\\n\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\\"':\n\t\t\t\t\t\tprintf(\"\\\\\\\"\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\\\':\n\t\t\t\t\t\tprintf(\"\\\\\\\\\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\t':\n\t\t\t\t\t\tprintf(\"\\\\t\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tdefault:\n\t\t\t\t\t\tputc(prog[j], stdout);\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\telse\n\t\t\tprintf(\"%c\", prog[i]);\n\t}\n}\n\n/* juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\" */\nint\nmain(void) {\n\t/* this is a comment */\n\tdr_quine();\n\treturn (0);\n}\n";

static void
dr_quine(void) {
	if (!prog)
		return ;
	for (size_t i = 0; prog[i]; i++) {
		if (prog[i] == 64) {
			for (size_t j = 0; prog[j]; j++) {
				switch (prog[j]) {
					case '\n':
						printf("\\n");
						break ;
					case '\"':
						printf("\\\"");
						break ;
					case '\\':
						printf("\\\\");
						break ;
					case '\t':
						printf("\\t");
						break ;
					default:
						putc(prog[j], stdout);
				}
			}
		}
		else
			printf("%c", prog[i]);
	}
}

/* juste be your self, do the best. "Wanting to be someone else is a waste of the person you are." */
int
main(void) {
	/* this is a comment */
	dr_quine();
	return (0);
}
