NAME := Colleen
ASM := nasm
ASMFLAGS := -f elf64
LD := ld
LDFLAGS :=
SRCS_DIR := src/
OBJ_DIR := .build/
SOURCES :=	$(SRCS_DIR)dr-quine.asm	\

OBJS := $(SOURCES:$(SRCS_DIR)%.asm=$(OBJ_DIR)%.o)

all: $(NAME)

$(NAME): $(OBJS)
	$(LD) $(OBJS) -o $(NAME)

$(OBJ_DIR)%.o: $(SRCS_DIR)%.asm
	@mkdir -p $(@D)
	$(ASM) $(ASMFLAGS) $< -o $@

gdb: $(NAME)
	gdb $(NAME)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re gdb