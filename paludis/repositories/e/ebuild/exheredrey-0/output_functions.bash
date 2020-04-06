#!/usr/bin/env bash
# vim: set sw=4 sts=4 et :

# Copyright (c) 2006, 2007, 2008, 2010, 2011, 2013 Ciaran McCreesh
#
# This file is part of the Paludis package manager. Paludis is free software;
# you can redistribute it and/or modify it under the terms of the GNU General
# Public License, version 2, as published by the Free Software Foundation.
#
# Paludis is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA

ebuild_notice()
{
    [[ -z "${PALUDIS_PIPE_COMMANDS_SUPPORTED}" ]] && return
    paludis_pipe_command LOG "$EAPI" "$@" >/dev/null
}

ebuild_section()
{
    [[ -n ${PALUDIS_EBUILD_QUIET} ]] && return
    echo -ne "${COLOUR_PINK}===${COLOUR_NORMAL} "
    [[ ${PALUDIS_PIPE_COMMANDS_STATUS_SUPPORTED} == "yes" ]] && \
        paludis_pipe_command LOG "$EAPI" "status" "${COLOUR_PINK}===${COLOUR_NORMAL} $@" >/dev/null
    echo "$@"
}

exlogfailure()
{
    paludis_pipe_command KEEP_LOGS "$EAPI" "$@" >/dev/null
}

exsetscmrevision()
{
    paludis_pipe_command SET_SCM_REVISION "$EAPI" "$@" >/dev/null
}

exdirectory()
{
    [[ "${!PALUDIS_EBUILD_PHASE_VAR}" == "setup" ]] || \
        die "exdirectory must be called in pkg_setup"

    paludis_pipe_command PERMIT_DIRECTORY "$EAPI" "$@" >/dev/null
}

expart()
{
    paludis_pipe_command PARTITION "$EAPI" "$@" >/dev/null
}

exvolatile()
{
    [[ "${!PALUDIS_EBUILD_PHASE_VAR}" == "setup" ]] || \
        die "exvolatile must be called in pkg_setup"

    local x
    for x in "$@"; do
        paludis_pipe_command VOLATILE "$EAPI" "$x" >/dev/null
    done
}

