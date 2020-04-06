#!/usr/bin/env bash
# vim: set sw=4 sts=4 et :

# Copyright (c) 2007, 2008 Ciaran McCreesh
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

default_pkg_info()
{
    verify_not_called_cross_phase ${FUNCNAME[0]#default_}
    :
}

pkg_info()
{
    default "$@"
}

exheres_internal_info()
{
    if hasq "info" ${SKIP_FUNCTIONS} ; then
        ebuild_section "Skipping pkg_info (SKIP_FUNCTIONS)"
    else
        ebuild_section "Starting pkg_info"
        pkg_info
        ebuild_section "Done pkg_info"
    fi

    true
}
