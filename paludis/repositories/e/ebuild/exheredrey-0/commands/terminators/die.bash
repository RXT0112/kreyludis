#!/usr/bin/env bash

###! Abstract: Provide a wrapper that terminates the shell and outputs a helpful message
###!
###! SYNOPSIS: die [arg] (message)
###!
###! Example:
###!
###!    user@example~$ die 1 "message"
###!    FATAL: message
###!
###! Additional info:
###! - End-users are expecte to have the ability to set format string using '$PALUDIS_DIE_FORMAT' in $paludisdir/bashrc

die() {
	case "$1" in
		36)
			case "$LANG" in
				cs-*) printf 'BEZPEČNOST: %s\n' "$2" ;;
				en-*|*) printf 'SECURITY: %s\n' "$2"
			esac
		;;
		256) # Unexpected handling
			case "$LANG" in
				cs-*) printf 'NEOČEKÁVANÉ: Neočekávané se stalo během %s\n' "$2" ;;
				en-*|*) printf 'UNEXPECTED: Unexpected happend while %s\n' "$2"
			esac
		;;
		ping) # Ping used for development
			if [ -z "$2" ]; then
				printf '%s\n' "ping"
			elif [ -n "$2" ]; then
				printf 'PING: %s\n' "$2"
			else
				printf 'FATAL: %s\n' "Unexpected happend while processing function ${FUNCNAME[0]} with argument '$1'"
				exit 256
			fi
		;; 
		*)
			if [ -z "$PALUDIS_DIE_FORMAT" ]; then
				printf 'FATAL: %s\n' "$2"
			elif [ -n "$PALUDIS_DIE_FORMAT" ]; then
				# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
				printf "$PALUDIS_DIE_FORMAT" "$2"
			else
				printf 'FATAL: %s\n' "Unexpected happend while processing function ${FUNCNAME[0]} with '$1'"
				exit 256
			fi
	esac

	exit "$1"
}