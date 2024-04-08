# Variables
CC              := gcc
CFLAGS          := -Wall -Wextra -Werror -Iinc -Isrc -O3

RM              := rm -rf
MINITALK        := minitalk
SERVER          := server
CLIENT          := client
NAME            := $(MINITALK) $(SERVER) $(CLIENT)

SERVER_SRC      := src/server.c
CLIENT_SRC      := src/client.c

# Librariestion is defined in both libft.a and libftprintf.a, it can lead to conflicts during linking.
LIBFT           := libft.a
LIBFT_DIR       := lib/ft_printf/lib/libft
LIBFT_FILE      := $(LIBFT_DIR)/$(LIBFT)
CFLAGS          += -I$(LIBFT_DIR)/inc

FT_PRINTF       := libftprintf.a
FT_PRINTF_DIR   := lib/ft_printf
FT_PRINTF_FILE  := $(FT_PRINTF_DIR)/$(FT_PRINTF)
CFLAGS          += -I$(FT_PRINTF_DIR)/inc

MAKE_LIB        := make --no-print-directory -s -C

# Source and Object Files
INC             := inc/minitalk.h

# Rules
all: $(NAME)

$(MINITALK): $(SERVER) $(CLIENT)
	@echo "\033[1;32m[$(MINITALK)] created successfully.\033[0]"

$(SERVER): $(SERVER_SRC) $(FT_PRINTF_FILE) $(LIBFT_FILE)
	@$(CC) $(CFLAGS) $^ -o $@
	@echo "\033[1;32m[$(SERVER)] created successfully.\033[0]"

$(CLIENT): $(CLIENT_SRC) $(FT_PRINTF_FILE) $(LIBFT_FILE)
	@$(CC) $(CFLAGS) $^ -o $@
	@echo "\033[1;32m[$(CLIENT)] created successfully.\033[0]"

$(LIBFT_FILE):
	@$(MAKE_LIB) $(LIBFT_DIR)

$(FT_PRINTF_FILE):
	@$(MAKE_LIB) $(FT_PRINTF_DIR)

lib_clean:
	@$(MAKE_LIB) $(LIBFT_DIR) clean
	@$(MAKE_LIB) $(FT_PRINTF_DIR) clean
	@echo "\033[1;33m[$(NAME)] Object files deleted.\033[0m"

lib_fclean:
	@$(MAKE_LIB) $(LIBFT_DIR) fclean
	@$(MAKE_LIB) $(FT_PRINTF_DIR) fclean
	@echo "\033[1;31m[$(NAME)] Program deleted.\033[0m"

clean:  lib_clean
	@$(RM) $(NAME)

fclean: clean lib_fclean

re: fclean all

.PHONY: all clean fclean re
