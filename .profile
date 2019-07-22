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

sakura_func()
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

# User defined aliases
alias ll="ls -lA --color --time-style=+%Y/%m/%d\ %H:%M"
alias sak=sakura_func
alias sedcp=sed_copy
alias pp=popd
alias difuc="diff -u --color"
alias dorf=dorf_func
alias windiff=windiff_func
alias calw="echo $(($(date +%W) + 1))"
alias start="explorer.exe ."

alias svndiff=svndiff_func
alias svnst=svnst_func
alias svnclean="svn cleanup --remove-unversioned"

# Read git completions
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

# Add path
export PATH=$PATH:/usr/bin/gibo/
