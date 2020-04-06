#!/usr/bin/env bash
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2019 under the terms of GPL-3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

# NOTICE: This script is compatible with POSIX sh

###! Abstract:
###! - Command used to output relevant information for end-user
###!
###! SYNOPSIS: einfo [message]
###!
###! Example:
###!
###!    user@example~$ einfo "Something"
###!    INFO: Something
###!
###! Additional informations:
###! - Can be customized using PALUDIS_EINFO_FORMAT

einfo() {
	if [ -z "$PALUDIS_EINFO_FORMAT" ]; then
		# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
		printf "$PALUDIS_EINFO_FORMAT" "$1"
		return 0
	elif [ -n "$PALUDIS_EINFO_FORMAT" ]; then
		printf 'ERROR: %s\n' "$1"
		return 0
	else
		case "$LANG" in
			cs-*) die 256 "zpracování proměnné PALUDIS_EINFO_FORMAT s hodnotou '$PALUDIS_EINFO_FORMAT' ve funkci '${FUNCNAME[0]}'" ;;
			en-*|*) die 256 "processing variable PALUDIS_EINFO_FORMAT with value '$PALUDIS_EINFO_FORMAT' in function '${FUNCNAME[0]}'"
		esac
	fi
}