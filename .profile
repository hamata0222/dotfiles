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
        run_other_proc /cygdrive/c/Program\ Files/WinMerge/WinMergeU.exe `cygpath -aw "$*"`
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
    if [ $1 == "st" ]; then
        command git status "${@:2}"
    elif [ $1 == "diffname" ]; then
        command git diff --name-only --relative "${@:2}"
    elif [ $1 == "ls" ]; then
        command git ls-files "${@:2}"
    elif [ $1 == "cb" ]; then
        command git checkout -b "${@:2}"
    else
        command git "$@"
    fi
}

func_calw()
{
    pre_lang=${LANG}
    
    LANG=en_GB.utf8
    monday=$(date --date='last Mon' +%d)
    friday=$(date --date='next Fri' +%d)
    date --date='next Fri' +"CW%V (%b. ${monday}th - %b. ${friday}th)"
    
    LANG=${pre_lang}
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
alias start="explorer.exe"

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
