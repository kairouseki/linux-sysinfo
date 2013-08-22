#!/usr/bin/python

import socket
import executil
from sysversion import fmt_sysversion

def fmt_welcome():
    welcome = "Welcome to %s" % socket.gethostname().capitalize()
    noyau = executil.getoutput("uname -mr")
    sysversion = fmt_sysversion()
    if sysversion:
        welcome += ", " + sysversion + " (" + noyau + ")"

    return welcome

def indent(level, s):
    return "\n".join([ (" " * level + line) 
                       for line in s.splitlines() ])

def main():
    print indent(2,fmt_welcome())

    try:
        sysinfo = executil.getoutput("/usr/lib/sysinfo/sysinfo.py")
        print
        print indent(2, sysinfo)
        print
    except executil.ExecError:
        pass

if __name__ == "__main__":
    main()

