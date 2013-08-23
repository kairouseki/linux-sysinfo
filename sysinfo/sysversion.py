# Copyright (c) 2010 Liraz Siri <liraz@turnkeylinux.org>
#
# This file is part of turnkey-pylib.
#
# turnkey-pylib is open source software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or (at your option) any later version.

import os
import re
import executil

"""
	Return a formatted distribution string:
    e.g. : Debian 7.1 Wheezy
    
    Output by lsb_release tool :
    
	Distributor ID:	Debian
	Description:	Debian GNU/Linux 7.1 (wheezy)
	Release:		7.1
	Codename:		wheezy
"""
def fmt_base_distribution():
    try:
        output = executil.getoutput("lsb_release -ircd")
    except executil.ExecError:
        return

    d = dict([ line.split(':\t') 
               for line in output.splitlines() ])

    codename = d['Codename'].capitalize()
    basedist = "%s %s %s" % (
    						d['Distributor ID'],
                            d['Release'],
                            d['Codename'].capitalize()
                            )
    if d['Codename'] in ('hardy', 'lucid', 'precise'):
        basedist += " LTS"

    return basedist

def fmt_sysversion():
    version = []

    basedist = fmt_base_distribution()
    if basedist:
        version.append(basedist)

    return ' / '.join(version)
