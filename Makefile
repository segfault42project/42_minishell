# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rabougue <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/12/10 19:16:51 by rabougue          #+#    #+#              #
#    Updated: 2017/04/10 03:47:29 by rabougue         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

####################################_COLOR_#####################################
GREEN = \033[38;5;10m
GREY = \033[38;5;60m
RED = \033[38;5;9m
END = \033[0m
##################################_COMPILATION_#################################
NAME = minishell
CC = gcc
FLAG = -Weverything
#FLAG = -Wall -Wextra -Werror
LFT = ./libft/libft.a
SRCS =	./source/main.c\
		./source/built_in.c\
		./source/built_in_cd.c\
		./source/env.c\
		./source/lst.c\
		./source/lst_2.c\
		./source/tools.c\
		./source/execute.c\
		./source/unsetenv.c\

OBJS = $(SRCS:.c=.o)

INCLUDE = -I ./include \
		  -I ./libft
###########################_RELINK_MODIFY_.h####################################
RELINK = ./include/minishell.h
################################################################################

all: $(NAME)

$(NAME): $(OBJS)
	@make -s -C ./libft/
	@$(CC) $(FLAG) -o $(NAME) $(OBJS) $(LFT)
	@printf "✅  Compilation done.\n"

%.o : %.c $(RELINK) ./Makefile
	@printf " ✅                                                              \r"
	@printf "✅  $(notdir $<)\r"
	@$(CC) -c $(FLAG) $< -o $@ $(INCLUDE)

clean:
	@printf "                                                               \r"
	@printf "✅  all .o deleted\n"
	@rm -f $(OBJS)
	@make -s clean -C ./libft/

fclean:
	@printf "                                                               \r"
	@printf "✅  libft.a, all .o and minishell deleted\n"
	@rm -f $(NAME) $(OBJS)
	@make -s fclean -C ./libft/

norme:
	norminette | grep Error

re: fclean all
