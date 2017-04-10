/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rabougue <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/04/09 05:08:03 by rabougue          #+#    #+#             */
/*   Updated: 2017/04/10 05:17:30 by rabougue         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../include/minishell.h"

static void	quit(t_ctrl *ctrl)
{
	t_environ	*tmp;

	tmp = ctrl->first;
	while (ctrl->first->next)
	{
		while (tmp->next->next)
			tmp = tmp->next;
		/*ft_dprintf(1, "%s\n", tmp->next->env);*/
		ft_strdel(&tmp->next->env);
		free(tmp->next);
		tmp->next = NULL;
		tmp = ctrl->first;
	}
	ft_strdel(&tmp->env);
	free(tmp);
	tmp = NULL;
}

int	main(int argc, char **argv)
{
	char	*line;
	t_ctrl	ctrl;

	line = NULL;
	ft_memset(&ctrl, 0, sizeof(t_ctrl));
	create_env(&ctrl);
	if (argc != 1)
	{
		ft_dprintf(2, "Too many arguments");
		return (EXIT_FAILURE);
	}
	else
	{
		while (0xDEADBEEF)
		{
			ft_dprintf(1, CYAN"$> "END);
			get_next_line(STDERR_FILENO, &line);
			if (line != NULL && ft_strlen(line) > 0)
				if (built_in(line, &ctrl) == EXIT_SUCCESS)
				{
					ft_strdel(&line);
					break ;
				}
			ft_strdel(&line);
		}
	}
	quit(&ctrl);
	return (0);
}