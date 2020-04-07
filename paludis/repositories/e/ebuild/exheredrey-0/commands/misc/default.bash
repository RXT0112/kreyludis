#!/bin/false
# shellcheck shell=bash # This file is expected to be sourced by paludis backend only

###! Abstract:
###! - This is simple wrapper expecting to use the default phase logic if used within the function
###! -- EXAMPLE: if 'default' is used in 'src_unpack()' function, then we are expecting to call `src_unpack_default`

default() {
	efixme "Function '${FUNCNAME[0]}' requires sanitization"
	efixme "Function '${FUNCNAME[0]}' requires sanity-check"
	"${FUNCNAME[1]}_default"
}