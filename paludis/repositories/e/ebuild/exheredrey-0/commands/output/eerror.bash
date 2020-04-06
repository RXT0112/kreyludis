#!/usr/bin/env bash
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020 under the terms of GPL-3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

# NOTICE: This script is compatible with POSIX sh

###! Abstract:
###! - Command used to output relevant information for end-user
###!
###! SYNOPSIS: eerror [message]
###!
###! Example:
###!
###!    user@example~$ eerror "Something failed"
###!    ERROR: Something failed
###!
###! Additional informations:
###! - Can be customized using PALUDIS_EERROR_FORMAT

einfo() {
	if [ -z "$PALUDIS_EERROR_FORMAT" ]; then
		# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
		printf "$PALUDIS_EERROR_FORMAT" "$1"
		return 0
	elif [ -n "$PALUDIS_EERROR_FORMAT" ]; then
		printf 'ERROR: %s\n' "$1"
		return 0
	else
		case "$LANG" in
			cs-*) die 256 "zpracování proměnné PALUDIS_EERROR_FORMAT s hodnotou '$PALUDIS_EERROR_FORMAT' ve funkci '${FUNCNAME[0]}'" ;;
			en-*|*) die 256 "processing variable PALUDIS_EERROR_FORMAT with value '$PALUDIS_EERROR_FORMAT' in function '${FUNCNAME[0]}'"
		esac
	fi
}