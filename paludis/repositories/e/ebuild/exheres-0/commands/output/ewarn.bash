#!/usr/bin/env bash
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020 under the terms of GPL-3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

# NOTICE: This script is compatible with POSIX sh

###! Abstract:
###! - Command used to output relevant information for end-user
###!
###! SYNOPSIS: ewarn [message]
###!
###! Example:
###!
###!    user@example~$ ewarn "Something"
###!    WARN: Something failed
###!
###! Additional informations:
###! - Can be customized using PALUDIS_EWARN_FORMAT

einfo() {
	if [ -z "$PALUDIS_EWARN_FORMAT" ]; then
		# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
		printf "$PALUDIS_EWARN_FORMAT" "$1"
		return 0
	elif [ -n "$PALUDIS_EWARN_FORMAT" ]; then
		printf 'ERROR: %s\n' "$1"
		return 0
	else
		case "$LANG" in
			cs-*) die 256 "zpracování proměnné PALUDIS_EWARN_FORMAT s hodnotou '$PALUDIS_EWARN_FORMAT' ve funkci '${FUNCNAME[0]}'" ;;
			en-*|*) die 256 "processing variable PALUDIS_EWARN_FORMAT with value '$PALUDIS_EWARN_FORMAT' in function '${FUNCNAME[0]}'"
		esac
	fi
}