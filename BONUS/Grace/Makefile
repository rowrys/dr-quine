NIM := nim
NAME := Grace
SRCS_DIR := ./
SOURCES :=	dr_quine.nim	\

SOURCES	:=	$(addprefix $(SRCS_DIR), $(SOURCES))
NIMFLAGS := c

all: $(NAME)

$(NAME): $(SOURCES)
	$(NIM) -o=$@ $(NIMFLAGS) $<

gdb: $(NAME)
	gdb -tui $(NAME)

clean:
	rm -rf $(NAME)

fclean: clean
	rm -rf $(NAME)

re: fclean all

.PHONY: all fclean clean re gdb