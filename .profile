# Export some working directories
shopt -s cdable_vars
if [ -f ~/.working_dirs ]; then
    source ~/.working_dirs
fi

# User defined functions
run_other_proc()
{
    set +m
    "$@" &
}

func_sakura()
{
    if [ ${TERM} = "cygwin" ]; then
        run_other_proc sakura `cygpath -aw "$*"`
    else
        run_other_proc sakura $@
    fi
}

windiff_func()
{
    if [ ${TERM} = "cygwin" ]; then
        run_other_proc /cygdrive/c/Program\ Files/WinMerge/WinMergeU.exe `cygpath -aw $*`
    else
        run_other_proc /c/Program\ Files/WinMerge/WinMergeU.exe $@
    fi
}

sed_copy()
{
    if [ $# -gt 0 ]; then
        export wkdir=$1
    else
        export wkdir=${wkdir}
    fi
    echo wkdir = ${wkdir}
    sed -E 's/(.*)/cp --parents \1 ${wkdir}/g'
}

svnst_func()
{
    svn st $@ | sed -E 's/([^ ]+)\s+(.*)/\2/g' | sed 's/\\/\//g'
}

svndiff_func()
{
    svn diff $@ --diff-cmd=diff -x '-u --color'
}

dorf_func()
{
    PASSED=$1

    if   [ -d "${PASSED}" ]
    then echo "${PASSED} is a directory";
    elif [ -f "${PASSED}" ]
    then echo "${PASSED} is a file";
    else echo "${PASSED} is not valid";
         exit 1
    fi
}

func_git()
{
    if [ $1 = "st" ]; then
        command git status "${@:2}"
    elif [ $1 = "diffname" ]; then
        command git diff --name-only --relative "${@:2}"
    elif [ $1 = "ls" ]; then
        command git ls-files "${@:2}"
    elif [ $1 = "cb" ]; then
        command git checkout -b "${@:2}"
    elif [ $1 = "sw" ]; then
        command git checkout "${@:2}"
    else
        command git "$@"
    fi
}

func_calw()
{
    pre_lang=${LANG}
    
    LANG=en_GB.utf8
    local monday=$(date --date='last Mon' +%-d)
    monday=$(func_convert_date_rank ${monday})
    monday=$(date --date='last Mon' +"%b. ${monday}")
    local friday=$(date --date='next Fri' +%-d)
    friday=$(func_convert_date_rank ${friday})
    friday=$(date --date='next Fri' +"%b. ${friday}")
    date --date='next Fri' +"CW%V (${monday} - ${friday})"
    
    LANG=${pre_lang}
}

func_convert_date_rank()
{
    local ret=
    local lsd=$(($1 % 10))
    if [ $1 -gt 10 -a $1 -lt 20 ]; then
        ret=$1"th"
    elif [ $lsd -eq 1 ]; then
        ret=$1"st"
    elif [ $lsd -eq 2 ]; then
        ret=$1"nd"
    elif [ $lsd -eq 3 ]; then
        ret=$1"rd"
    else
        ret=$1"th"
    fi
    echo $ret
}

func_start()
{
    if [ $# -eq 0 ]; then
        command explorer.exe .
    elif [[ $1 = *"/"* ]]; then
        command pushd "$(dirname $1)" > /dev/null; command explorer.exe "$(basename $1)"; command popd > /dev/null;
    else
        command explorer.exe "$1"
    fi
}

# User defined aliases
alias ll="ls -lA --color --time-style=+%Y/%m/%d\ %H:%M"
alias sak=func_sakura
alias sedcp=sed_copy
alias pp=popd
alias difuc="diff -u --color"
alias dorf=dorf_func
alias windiff=windiff_func
alias calw=func_calw
alias start=func_start

alias svndiff=svndiff_func
alias svnst=svnst_func
alias svnclean="svn cleanup --remove-unversioned"

alias git=func_git

# Read git completions
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

# Add path
export PATH=$PATH:/usr/bin/gibo/

# Environment Variable for 'less'
export LESS='-r -X -K -F'

# Colors setting
eval `dircolors ~/.dircolors`

# Above setting is more common. Below one is special setting.
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
export DISPLAY=$(ipconfig.exe | grep "IPv4" | head -1 | awk '{print $NF}' | awk 'sub(/\r$/, "")'):0

