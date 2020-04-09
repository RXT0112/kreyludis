#!/bin/false
# shellcheck shell=bash # This file is expected to be sourced by paludis backend only

###! Abstract:
###! - This phase is expected to be used to extract source files inside the WORKBASE with the option to rename the files on demand based on variable DOWNLOADS's value
###! - Name of the required archives is expected to be stored in variable ARCHIVES separated by space ' '

src_unpack_default() {
	edebug 2 "Variable ARCHIVES stores following value(s): '$ARCHIVES' in function ${FUNCNAME[0]}"

	# Check if there is anything to extract
	# FIXME: Extract only if required to (skip if expected directory is already present)
	if [ -n "$ARCHIVES" ]; then
		edebug 2 "Phase '${FUNCNAME[0]}' is processing archives: $ARCHIVES"

		# Process all archives
		for archive in $ARCHIVES; do
			# FIXME: This does not allow renaming from DOWNLOADS variable above
			# FIXME: inefficeint(awk needed) -- archiveName="$(sed -E "s#(${archive//./\\.}\s+->\s+)([^\n]+)#\2#gm")"
			# NOTICE: Keep tar.xz and tar.gz separated for later development to offer alternatives for extraction
			case "$archive" in
				*.tar.xz) 
					if command -v tar >/dev/null; then
						edebug 2 "Command 'tar' is available for phase ${FUNCNAME[0]}"
						edebug 1 "Phase '${FUNCNAME[0]}' is extracting '$FETCHEDDIR/$archive' in '$WORKBASE' renamed as '$WORKBASE'"

						# CORE
						tar xpJf "$FETCHEDDIR/$archive" -C "$WORKBASE" || die 1 "Unable to extract archive '$archive' in path '$WORKBASE'"

						edebug 1 "Phase '${FUNCNAME[0]}' sucessfully extracted archive '$FETCHEDDIR/$archive' in '$WORKBASE' renamed as '$WORKBASE'"
					elif ! command -v tar >/dev/null; then
						case "$LANG" in
							en-*|*) die bug "This ebuild for package '$P' requires command 'tar' for extracting of archive '$archive' to '$WORKBASE' which is not available to phase '${FUNCNAME[0]}'"
						esac
					else
						case "$LANG" in
							en-*|*) die 255 "checking if command 'tar' is available to us"
						esac
					fi
				;;
				*.tar.gz) 
					if command -v tar >/dev/null; then
						edebug 2 "Command 'tar' is available for phase ${FUNCNAME[0]}"
						edebug 1 "Phase '${FUNCNAME[0]}' is extracting '$FETCHEDDIR/$archive' in '$WORKBASE' renamed as '$WORKBASE'"
						# CORE
						tar xpzf "$FETCHEDDIR/$archive" -C "$WORKBASE" || die 1 "Unable to extract archive '$archive' in path '$WORKBASE'"
						edebug 1 "Phase '${FUNCNAME[0]}' sucessfully extracted archive '$FETCHEDDIR/$archive' in '$WORKBASE' renamed as '$WORKBASE'"
					elif ! command -v tar >/dev/null; then
						case "$LANG" in
							en-*|*) die bug "This ebuild for package '$P' requires command 'tar' for extracting of archive '$archive' to '$WORKBASE'"
						esac
					else
						case "$LANG" in
							en-*|*) die 255 "checking if command 'tar' is available to us"
						esac
					fi
				;;
				*.zip) die unimplemented "Extraction of zip archives is not yet implemented" ;;
				*.rar) die unimplemented "Extraction of rar archives is not yet implemented" ;;
				*)
					case "$LANG" in
						cs-*) die 255 "nepodporovaný archiv '$archive' byl předán do funkce '${FUNCNAME[0]}', nemůžeme extrahovat" ;;
						en-*|*) die 255 "unsupported archive '$archive' has been parsed in function '${FUNCNAME[0]}', unable to extract"
					esac
			esac
		done
	elif [ -z "$ARCHIVES" ]; then
		einfo "Variable ARCHIVES '$ARCHIVES' is blank, nothing to extract.."
		return 0
	else
		die 255 "Unexpected happend while processing variable ARCHIVES with value '$ARCHIVES'"
	fi

	die bug "Logic in phase '${FUNCNAME[0]}' escaped sanitization"
}

src_unpack() {
		default
}