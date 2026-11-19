#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

const char* prog = "#include <stdint.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <unistd.h>\n\nconst char* prog = \"@\";\nconst uint8_t sully = 5;\n\nstatic void\ndr_quine(FILE* file) {\n\tif (!prog)\n\t\treturn ;\n\tfor (size_t i = 0; prog[i]; i++) {\n\t\tif (prog[i] == 64) {\n\t\t\tfor (size_t j = 0; prog[j]; j++) {\n\t\t\t\tif (prog[j] - '0' == sully && prog[j + 1] == ';') {\n\t\t\t\t\tfprintf(file, \"%c\", sully + '0' - 1);\n\t\t\t\t\tcontinue ;\n\t\t\t\t}\n\t\t\t\tswitch (prog[j]) {\n\t\t\t\t\tcase '\\n':\n\t\t\t\t\t\tfprintf(file, \"\\\\n\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\\"':\n\t\t\t\t\t\tfprintf(file, \"\\\\\\\"\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\\\':\n\t\t\t\t\t\tfprintf(file, \"\\\\\\\\\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tcase '\\t':\n\t\t\t\t\t\tfprintf(file, \"\\\\t\");\n\t\t\t\t\t\tbreak ;\n\t\t\t\t\tdefault:\n\t\t\t\t\t\tputc(prog[j], file);\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\telse if (prog[i] - '0' == sully && prog[i + 1] == ';')\n\t\t\tfprintf(file, \"%c\", sully + '0' - 1);\n\t\telse\n\t\t\tfprintf(file, \"%c\", prog[i]);\n\t}\n}\n\n// juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\"\nint\nmain(void) {\n\tchar buffer[] = {'c', 'c', ' ', 'S', 'u', 'l', 'l', 'y', '_', sully + '0', '.', 'c', 0};\n\tconst char* file_name = buffer + 3 ;\n\tif (!sully)\n\t\treturn (0);\n\tFILE* file = fopen(file_name, \"w\");\n\tif (!file)\n\t\treturn (1);\n\tdr_quine(file);\n\tfclose(file);\n\tprintf(\"Sully{%d}\\n\", sully);\n\tchar cmd[] = \"cc Sully_5.c && ./a.out\";\n\tcmd[9] = sully + '0';\n\texecl(\"/bin/sh\", \"sh\", \"-c\", cmd, NULL);\n\treturn (0);\n}\n";
const uint8_t sully = 5;

static void
dr_quine(FILE* file) {
	if (!prog)
		return ;
	for (size_t i = 0; prog[i]; i++) {
		if (prog[i] == 64) {
			for (size_t j = 0; prog[j]; j++) {
				if (prog[j] - '0' == sully && prog[j + 1] == ';') {
					fprintf(file, "%c", sully + '0' - 1);
					continue ;
				}
				switch (prog[j]) {
					case '\n':
						fprintf(file, "\\n");
						break ;
					case '\"':
						fprintf(file, "\\\"");
						break ;
					case '\\':
						fprintf(file, "\\\\");
						break ;
					case '\t':
						fprintf(file, "\\t");
						break ;
					default:
						putc(prog[j], file);
				}
			}
		}
		else if (prog[i] - '0' == sully && prog[i + 1] == ';')
			fprintf(file, "%c", sully + '0' - 1);
		else
			fprintf(file, "%c", prog[i]);
	}
}

// juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."
int
main(void) {
	char buffer[] = {'c', 'c', ' ', 'S', 'u', 'l', 'l', 'y', '_', sully + '0', '.', 'c', 0};
	const char* file_name = buffer + 3 ;
	if (!sully)
		return (0);
	FILE* file = fopen(file_name, "w");
	if (!file)
		return (1);
	dr_quine(file);
	fclose(file);
	printf("Sully{%d}\n", sully);
	char cmd[] = "cc Sully_5.c && ./a.out";
	cmd[9] = sully + '0';
	execl("/bin/sh", "sh", "-c", cmd, NULL);
	return (0);
}
