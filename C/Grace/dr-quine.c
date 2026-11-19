#include <stdio.h>

#define prog "#include <stdio.h>\n\n#define prog \"@\"\n\n#define DR_QUINE static void\t\t\t\t\t\\\ndr_quine(FILE* file) {\t\t\t\t\t\t\t\\\n\tif (!prog)\t\t\t\t\t\t\t\t\t\\\n\t\treturn ;\t\t\t\t\t\t\t\t\\\n\tfor (size_t i = 0; prog[i]; i++) {\t\t\t\\\n\t\tif (prog[i] == 64) {\t\t\t\t\t\\\n\t\t\tfor (size_t j = 0; prog[j]; j++) {\t\\\n\t\t\t\tswitch (prog[j]) {\t\t\t\t\\\n\t\t\t\t\tcase '\\n':\t\t\t\t\t\\\n\t\t\t\t\t\tfprintf(file, \"\\\\n\");\t\\\n\t\t\t\t\t\tbreak ;\t\t\t\t\t\\\n\t\t\t\t\tcase '\\\"':\t\t\t\t\t\\\n\t\t\t\t\t\tfprintf(file, \"\\\\\\\"\");\t\\\n\t\t\t\t\t\tbreak ;\t\t\t\t\t\\\n\t\t\t\t\tcase '\\\\':\t\t\t\t\t\\\n\t\t\t\t\t\tfprintf(file, \"\\\\\\\\\");\t\\\n\t\t\t\t\t\tbreak ;\t\t\t\t\t\\\n\t\t\t\t\tcase '\\t':\t\t\t\t\t\\\n\t\t\t\t\t\tfprintf(file, \"\\\\t\");\t\\\n\t\t\t\t\t\tbreak ;\t\t\t\t\t\\\n\t\t\t\t\tdefault:\t\t\t\t\t\\\n\t\t\t\t\t\tputc(prog[j], file);\t\\\n\t\t\t\t}\t\t\t\t\t\t\t\t\\\n\t\t\t}\t\t\t\t\t\t\t\t\t\\\n\t\t}\t\t\t\t\t\t\t\t\t\t\\\n\t\telse\t\t\t\t\t\t\t\t\t\\\n\t\t\tfprintf(file, \"%c\", prog[i]);\t\t\\\n\t}\t\t\t\t\t\t\t\t\t\t\t\\\n}\t\t\t\t\t\t\t\t\t\t\t\t\\\n\n#define MAIN int\t\t\t\t\t\t\t\t\\\nmain(void) {\t\t\t\t\t\t\t\t\t\\\n\tFILE* file = fopen(\"Grace_kid.c\", \"w\");\t\t\\\n\tif (!file) \t\t\t\t\t\t\t\t\t\\\n\t\treturn (1);\t\t\t\t\t\t\t\t\\\n\tdr_quine(file);\t\t\t\t\t\t\t\t\\\n\tfclose(file);\t\t\t\t\t\t\t\t\\\n\treturn (0);\t\t\t\t\t\t\t\t\t\\\n}\t\t\t\t\t\t\t\t\t\t\t\t\\\n\n\nDR_QUINE\n\n// juste be your self, do the best. \"Wanting to be someone else is a waste of the person you are.\"\nMAIN"

#define DR_QUINE static void					\
dr_quine(FILE* file) {							\
	if (!prog)									\
		return ;								\
	for (size_t i = 0; prog[i]; i++) {			\
		if (prog[i] == 64) {					\
			for (size_t j = 0; prog[j]; j++) {	\
				switch (prog[j]) {				\
					case '\n':					\
						fprintf(file, "\\n");	\
						break ;					\
					case '\"':					\
						fprintf(file, "\\\"");	\
						break ;					\
					case '\\':					\
						fprintf(file, "\\\\");	\
						break ;					\
					case '\t':					\
						fprintf(file, "\\t");	\
						break ;					\
					default:					\
						putc(prog[j], file);	\
				}								\
			}									\
		}										\
		else									\
			fprintf(file, "%c", prog[i]);		\
	}											\
}												\

#define MAIN int								\
main(void) {									\
	FILE* file = fopen("Grace_kid.c", "w");		\
	if (!file) 									\
		return (1);								\
	dr_quine(file);								\
	fclose(file);								\
	return (0);									\
}												\


DR_QUINE

// juste be your self, do the best. "Wanting to be someone else is a waste of the person you are."
MAIN