#!/bin/zsh

if [[ $(command -v antigen) ]]; then
	antigen bundle aubreypwd/zsh-plugin-require@1.0.1
	antigen apply

	require "{BREWCOMMAND}" "brew reinstall {BREWCOMMAND}" "brew"
fi

if ! [[ -x $(command -v {BREWCOMMAND}) ]]; then
	echo "Please install {BREWCOMMAND} to use {NAME}."
	return;
fi

###
 #
 #
 # @since 1.0.0
 ##
