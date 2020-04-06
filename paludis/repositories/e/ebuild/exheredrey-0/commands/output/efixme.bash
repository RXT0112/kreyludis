#!/usr/bin/env bash
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> in 2019 under the terms of GPL-3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

###! Abstract:
###! - Command used to output a FIXME message for features that are not yet implmented
###!
###! SYNOPSIS: efixme [message]
###!
###! Example:
###!
###!    if command -v wget >/dev/null; then
###!        efixme "only wget is currently supported, add more options for download"
###!        wget someurl -O somepath
###!    elif command -v curl >/dev/null; then
###!        die fixme "curl is not implemented"
###!    else
###!        die 255 "example of wget to fixme intro"
###!    fi
###!
###! Additional info:
###! - Messages are expected to be enabled by default unless PALUDIS_IGNORE_FIXME variable is set on '1'
###! - Can be customized using PALUDIS_EFIXME_FORMAT in $paludisdir/bashrc

efixme() {
	if [ -z "$PALUDIS_IGNORE_FIXME" ]; then
		# Allow end-user formatting changes
		if [ -n "$PALUDIS_EFIXME_FORMAT" ]; then
			printf "$PALUDIS_EFIXME_FORMAT" "$1"
			return 0
		elif [ -z "$PALUDIS_EFIXME_FORMAT" ]; then
			printf 'FIXME: %s\n' "$1"
			return 0
		else
			# FIXME-LOCAL: Add more translations
			case "$LANG" in
				cs-*) die 255 "exportování fixme zprávy"
				en-*|*) die 255 "exporting fixme message"
			esac
		fi
	elif [ "$PALUDIS_IGNORE_FIXME" = 1 ]; then
		return 0
	# Security trap
	elif [ -n "$PALUDIS_IGNORE_FIXME" ]; then
		die 36 "Variable 'PALUDIS_IGNORE_FIXME' does not support value '$PALUDIS_IGNORE_FIXME', supported value is '1' to disable fixme messages"
	else
		# POSIX: FUNCNAME is not recognized on POSIX sh
		die 256 "Processing 'PALUDIS_IGNORE_FIXME' with value '$PALUDIS_IGNORE_FIXME' in function ${FUNCNAME[0]}"
	fi
}