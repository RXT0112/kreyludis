#!/bin/false
# shellcheck shell=bash # This file is expected to be sourced by paludis backend only

###! Abstract:
###! - Download the required source code and cache it
###!   - This is expected to utilize available resources i.e use wget if we have it available
###!   - Do not download the source if it's already cache and cache passes the tests
###! - Check it agains virus total database for potential malicious code
###!   - Requires API KEY set by the end-user in PALUDIS_VIRUSTOTAL_API_KEY variable
###! - Check it agains provided checksum -> Fail if checksum does not match
###!   - Allow this being disabled within the ebuild
###! Additional info:
###! - Example of DOWNLOADS variable:
###!
###! DOWNLOADS="
###!     flag? ( https://some.url/bar.tar.xz -> new-name.tar.xz )
###!     https://other.url/baz.tar.xz -> renamed-baz.tar.xz"
###!
###!   - 'flag?' is expected to download only if paludis flag has been used

src_fetch_default() {
	# NOTICE: Checking blank is apparently faster -> Process it first (Sanity-check needed)
	if [ -z "$DOWNLOADS" ]; then
		edebug 1 "Variable DOWNLOADS with value '$DOWNLOADS' is blank, nothing to fetch.."
		return 0
	elif [ -n "$DOWNLOADS" ]; then
		die unimplemented "Logic for fetching sources is needed"

		# FIXME: Check if cached
	else
		die posix "FUNCNAME used"
		die 255 "processing DOWNLOADS variable with value '$DOWNLOADS' in function ${FUNCNAME[0]}"
	fi
}