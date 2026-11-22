GOOSE := goose
NAME := Colleen
SRCS_DIR := ./
SOURCES :=	dr-quine.goose	\

SOURCES	:=	$(addprefix $(SRCS_DIR), $(SOURCES))

OBJ_DIR := .build/

GOOSEFLAGS := -Wall -Werror -Wextra -pedantic-errors -g
INCLUDE := -I include/

all: $(NAME)
debug: $(NAME)

$(NAME): $(SOURCES)
	$(GOOSE) build $< -o $@

gdb: $(NAME)
	gdb -tui $(NAME)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -rf $(NAME)
	rm -fr $(BIN)

re: fclean all

.PHONY: all fclean clean re gdb