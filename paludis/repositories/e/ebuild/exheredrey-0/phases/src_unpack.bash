#!/bin/false
# - This file is expected to be sourced by paludis backend

# shellcheck shell=bash
# shellcheck disable=SC1008 # Using /bin/false to prevent invokation of library file

src_unpack_default() {
	edebug "Variable ARCHIVES stores following value(s): '$ARCHIVES' in function ${FUNCNAME[0]}"

	# FIXME: Implement logic for non-tar archives
	# FIXME: This does not allow renaming from DOWNLOADS variable above
	# Check if there is anything to extract
	if [ -n "$ARCHIVES" ]; then
		# Process all archives
		for archive in $ARCHIVES; do
			# Continue if the archive is not extracted already
			if [ ! -d "$WORKBASE/${archive%%.tar.??}" ]; then
				# Extract the archive if it's present
				if [ -e "$FETCHEDDIR/$archive" ]; then
					einfo "Extracting archive '$archive' to WORKBASE as instructed.."r
					# FIXME: This may fail on older versions of tar -> Supply -z flag accordingly
					tar xpf "$FETCHEDDIR/$archive" -C "$WORKBASE/${archive%%.tar.??}" || die 1 "Unable to extract archive '$FETCHEDDIR/$archive' to '$WORKBASE'"
					einfo "Archive '$archive' has been sucessfully extracted instructed WORKBASE"
				elif [ ! -e "$FETCHEDDIR/$archive" ]; then
					die 1 "Expected archive '$FETCHEDDIR/$archive' does not exists, unable to extract"
				else
					die 256 "Unexpected happend while trying to extract archive '$archive' in ${FUNCNAME[0]}"
				fi
			elif [ -d "$WORKBASE/${archive%%.tar.??}" ]; then
				einfo "Archive '$archive' is already extracted, skipping.."
			else
				die 256 "Unexpected happend while processing archive '$archive' in ${FUNCNAME[0]}"
			fi
		done
	elif [ -z "$ARCHIVES" ]; then
		einfo "Variable '$ARCHIVES' is blank, nothing to extract.."
	else
		die 256 "Unexpected happend while processing variable ARCHIVES with value '$ARCHIVES'"
	fi
}
