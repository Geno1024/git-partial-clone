#!/bin/bash

show_help() {
    cat << EOF
Usage: $0 [-h] [-b <name>] [-p <path>] <repository>

Clone specified path of repository at given branch.
EOF
}

while getopts ":hb:p:" OPT; do
    case $OPT in
        "h")
            show_help ;;
        "b")
            branch="$OPTARG" ;;
        "p")
            path="$OPTARG" ;;
        *)
            echo >&2 "Unrecognized option: $OPT" ;;
    esac
done

shift $((OPTIND - 1))
[[ $# -ne 0 ]] && url=$1

mkdir -p .git/partial
wget -O .git/partial/git-upload-pack -s "$url/info/refs?service=git-upload-pack"
