#!/bin/sh
#
# FILE:    singuname
# USAGE:   singuname
# PURPOSE: prints to stdout a unique identifier of known uname(s)
# AUTHOR:  obachman
# CREATED: 5/26/98
#
###########################################################################

egrep="egrep"
uname_a=`uname -a`
devnull='/dev/null'
file=file
binary='/bin/ls'
ldd='ldd'

# HPUX ########################################################
if (echo $uname_a | $egrep "HP-UX" > $devnull)
then
    prefix=HPUX
    # HPUX-9
    if (echo $uname_a | $egrep "\.09\." > $devnull)
    then
        echo ${prefix}-9
        exit 0
    # HPUX-10
    elif (echo $uname_a | $egrep "\.10\." > $devnull)
    then
        echo ${prefix}-10
        exit 0
    elif (echo $uname_a | $egrep " ia64 " > $devnull)
    then
        echo IA64-${prefix}
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# Intel ########################################################
elif (echo $uname_a | $egrep "i[3,4,5,6]86" > $devnull)
then
    prefix=ix86
    # Win ################
    if (echo $uname_a | $egrep "CYGWIN" > $devnull)
    then
        echo ${prefix}-Win
        exit 0
    # FreeBSD ###############
    elif (echo $uname_a | $egrep "FreeBSD" > $devnull)
    then
        echo ${prefix}-freebsd
        exit 0
    # Linux ###############
    elif (echo $uname_a | $egrep "Linux" > $devnull)
    then
        prefix=${prefix}-Linux
        if (test -x $file && -x $binary)
        then
            # LinuxAOUT only if  file does not match ELF
            if ($file $binary | $egrep -v "ELF" > $devnull)
            then
                echo ${prefix}AOUT
                exit 0
            fi
        fi
        # everything else is assumed to be Linux ELF
        # check for libc5
        if (echo `$ldd $binary` | $egrep "libc.so.5" > $devnull)
        then
            echo "${prefix}-libc5"
        else
            echo ${prefix}
        fi
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# SunOS ########################################################
elif (echo $uname_a | $egrep "SunOS" > $devnull)
then
    if (echo $uname_a | $egrep "sun3" > $devnull)
    then
      prefix=Sun3OS
    else
      prefix=SunOS
    fi
    if (echo $uname_a | $egrep "4\.[0-9]" > $devnull)
    then
        echo ${prefix}-4
        exit 0
    # Solaris
    elif (echo $uname_a | $egrep "5\.[0-9]" > $devnull)
    then
        echo ${prefix}-5
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# DecAlpha ########################################################
elif (echo $uname_a | $egrep "alpha" > $devnull)
then
    prefix=DecAlpha
    if (echo $uname_a | $egrep "Linux" > $devnull)
    then
        echo ${prefix}-Linux
        exit 0
    elif (echo $uname_a | $egrep "OSF1" > $devnull)
    then
        echo ${prefix}-OSF1
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# IRIX ########################################################
elif (echo $uname_a | $egrep "IRIX" > $devnull)
then
    prefix=IRIX
    if (echo $uname_a | $egrep "6\.[0-9]" > $devnull)
    then
        echo ${prefix}-6
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# AIX ########################################################
elif (echo $uname_a | $egrep "AIX" > $devnull)
then
    prefix=AIX
    if (uname -v |  $egrep "4" > $devnull)
    then
        echo ${prefix}-4
        exit 0
    elif (uname -v |  $egrep "3" > $devnull)
    then
        echo ${prefix}-3
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# Darwin/MacOS X ##############################################
elif (echo $uname_a | $egrep "Power Macintosh" > $devnull)
then
    prefix="ppcMac"
    if( uname -s | $egrep "Darwin" > $devnull)
    then
        echo ${prefix}-darwin
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# other PowerPC ##############################################
elif (echo $uname_a | $egrep "ppc" > $devnull)
then
    prefix="ppc"
    if (echo $uname_a | $egrep "Linux" > $devnull)
    then
        echo ${prefix}-Linux
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# itanium ########################################################
elif (echo $uname_a | $egrep "itanium" > $devnull)
then
    # IA64-HPUX: see HPUX
    prefix=IA64
    if (echo $uname_a | $egrep "Linux" > $devnull)
    then
        echo ${prefix}-Linux
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
# AMD-Opteron ########################################################
elif (echo $uname_a | $egrep "x86_64" > $devnull)
then
    prefix=x86_64
    if (echo $uname_a | $egrep "Linux" > $devnull)
    then
        echo ${prefix}-Linux
        exit 0
    else
        echo ${prefix}-Unknown
        exit 1
    fi
else # Unknown ########################################################
    echo Unknown
    exit 2
fi
