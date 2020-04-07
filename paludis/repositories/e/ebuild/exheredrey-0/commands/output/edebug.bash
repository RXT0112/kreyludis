#!/bin/false
# shellcheck shell=bash # This file is expected to be sourced by paludis backend only

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

# FIXME: Implement level debugging

# Example use in code assuming PALUDIS_DEBUG variable set on either 1,2 or 3:
# - 'edebug 1 "level 1 message"' -> Output 'DEBUG: level 1 message'
# - 'edebug 2 "level 2 message"' -> Output 'DEEP-DEBUG: level 1 message'2
# - 'edebug 3 "level 3 message"' -> Output 'TRACE: level 3 message'
# - 'edebug anything "something"' -> Error

edebug() {
	# NOTICE: Checking blank is apparently faster so process it first (FIXME: Sanity check needed)
	if [ -z "$PALUDIS_DEBUG" ]; then
		return 0
	# POSIX: Glob expansion used
	# FIXME-QA: Ugly af
	elif [[ "$PALUDIS_DEBUG" = @(1|2|3) ]]; then
		case "$1" in
			1)
				# FIXME: Also output if PALUDIS_DEBUG contains 1
				[[ "$PALUDIS_DEBUG" = @(1|2|3) ]] && printf 'DEBUG: %s\n' "$2"
				return 0
			;;
			2)
				# FIXME: Also output if PALUDIS_DEBUG contains 2
				[[ "$PALUDIS_DEBUG" = @(2|3) ]] && printf 'DEEP-DEBUG: %s\n' "$2" 
				return 0
			;;
			3)
				# FIXME: Also output if PALUDIS_DEBUG contains 3
				[ "$PALUDIS_DEBUG" = 3 ] && printf 'TRACE: %s\n' "$2"
				return 0
			;;
			*)
				die 255 "processing whatever"
		esac


		# # NOTICE: Allow end-user formatting changes
		# if [ -z "$PALUDIS_EDEBUG_FORMAT" ]; then
		# 	printf 'DEBUG: %s\n' "$1"
		# 	return 0
		# elif [ -n "$PALUDIS_EDEBUG_FORMAT" ]; then
		# 	# shellcheck disable=SC2059 # Variable in format string is expected to allow customization
		# 	printf "$PALUDIS_EDEBUG_FORMAT" "$1"
		# 	return 0
		# else
		# 	# FIXME-LOCAL: Add more translations
		# 	case "$LANG" in
		# 		cs-*) die 255 "exportování debugovací zprávy s formátem '$PALUDIS_EDEBUG_FORMAT' a levelem '1'" ;;
		# 		en-*|*) die 255 "exporting debug message with format '$PALUDIS_EDEBUG_FORMAT' and level '1'"
		# 	esac
		# fi
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
			cs-*)  die 255 "zpracování proměnné 'PALUDIS_DEBUG' s hodnotou '$PALUDIS_DEBUG' ve funkci '${FUNCNAME[0]}'" ;;
			en-*|*) die 255 "processing variable 'PALUDIS_DEBUG' with value '$PALUDIS_DEBUG' in function '${FUNCNAME[0]}'"
		esac
	fi
}