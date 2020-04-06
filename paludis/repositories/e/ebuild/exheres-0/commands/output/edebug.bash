#!/usr/bin/env bash
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2019 under GPL-3 <https://www.gnu.org/licenses/gpl-3.0.en.html> license

###! Abstract:
###! - Command used to output relevant information for end-user
###!
###! SYNOPSIS: edebug [message]
###!
###! Example:
###!
###!    user@example~$ edebug "Something"
###!    user@example~$ env DEBUG="1" edebug "Something"
###!    DEBUG: Something
###!
###! Additional informations:
###! - Can be customized using PALUDIS_EDEBUG_FORMAT

edebug() {
	# NOTICE: Checking blank is apparently faster so process it first
	if [ -z "$PALUDIS_DEBUG" ]; then
		return 0
	elif [ "$PALUDIS_DEBUG" = 1 ]; then
		# NOTICE: Allow end-user formatting changes
		if [ -z "$PALUDIS_EDEBUG_FORMAT" ]; then
			printf 'DEBUG: %s\n' "$1"
			return 0
		elif [ -n "$PALUDIS_EDEBUG_FORMAT" ]; then
			# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
			printf "$PALUDIS_EDEBUG_FORMAT" "$1"
			return 0
		else
			# FIXME-LOCAL: Add more translations
			case "$LANG" in
				cs-*) die 256 "exportování debugovací zprávy s formátem '$PALUDIS_EDEBUG_FORMAT'" ;;
				en-*|*) die 256 "exporting debug message with format '$PALUDIS_EDEBUG_FORMAT'"
			esac
		fi
	# Security trap
	elif [ -n "$PALUDIS_DEBUG" ]; then
		case "$LANG" in
			# FIXME-LOCAL: Add more translations
			cs-*) die 36 "Proměnná 'PALUDIS_DEBUG' nepodporuje hodnotu '$PALUDIS_DEBUG', podporovaná hodnota je '1' k aktivaci debugovacího módu" ;;
			en-*|*) die 36 "Variable 'PALUDIS_DEBUG' does not support value '$PALUDIS_DEBUG', supported value is '1' to enable debugging mode"
		esac
	else
		# POSIX: FUNCNAME is not recognized on POSIX sh
		case "$LANG" in
			cs-*)  die 256 "zpracování proměnné 'PALUDIS_DEBUG' s hodnotou '$PALUDIS_DEBUG' ve funkci '${FUNCNAME[0]}'" ;;
			en-*|*) die 256 "processing variable 'PALUDIS_DEBUG' with value '$PALUDIS_DEBUG' in function '${FUNCNAME[0]}'"
		esac
	fi
}