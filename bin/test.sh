#!/usr/bin/env bash

# error codes
export ERROR_SUCCESS=1
export ERROR_FAILURE=2

# error codes from version
export ERROR_VERSION_STRING=1
export ERROR_PART_FLAG=2

# base directory of this project
export BASE=$(cd $(dirname $BASH_SOURCE)/..; pwd -P)
export VERSION="$BASE/version.sh"

# test index
export COUNTER=0

# test that version correctly updates version string
success() {
    local VERSION="$1"
    local OUTPUT="$2"
    shift 2
    let COUNTER+=1
    printf "[%02d] $VERSION $@ ==> $OUTPUT... " $COUNTER
    if [ "$($VERSION $@ 2>/dev/null)" = "$OUTPUT" ]; then
         echo "Passed"
    else
        echo "Failed"
        exit $ERROR_SUCCESS
    fi
}

# test that version correctly fails on incorrect input
failure() {
    let COUNTER+=1
    local VERSION="$1"
    local ERROR="$2"
    shift 2
    printf "[%02d] $VERSION $@ fails with $ERROR... " $COUNTER
    if [ "$($VERSION $@ >/dev/null 2>&1; echo $?)" -eq "$ERROR" ]; then
        echo "Passed"
    else
        echo "Failed"
        exit $ERROR_FAILURE
    fi
}

success $VERSION 0.0.1 0.0.0

success $VERSION 0.0.1 0.0.0 --build
success $VERSION 0.1.0 0.0.0 --minor
success $VERSION 1.0.0 0.0.0 --major

success $VERSION 0.0.1 0.0.0 -b
success $VERSION 0.1.0 0.0.0 -i
success $VERSION 1.0.0 0.0.0 -a

success $VERSION 0.0.1 --build 0.0.0
success $VERSION 0.1.0 --minor 0.0.0
success $VERSION 1.0.0 --major 0.0.0

success $VERSION 0.0.1 -b 0.0.0
success $VERSION 0.1.0 -i 0.0.0
success $VERSION 1.0.0 -a 0.0.0

success $VERSION 1.0.0 --build --major 0.0.0
success $VERSION 1.0.0 -b --major 0.0.0
success $VERSION 1.0.0 --build -a 0.0.0
success $VERSION 1.0.0 -b -a 0.0.0

failure $VERSION $ERROR_VERSION_STRING
failure $VERSION $ERROR_VERSION_STRING ''
failure $VERSION $ERROR_VERSION_STRING 0
failure $VERSION $ERROR_VERSION_STRING .0
failure $VERSION $ERROR_VERSION_STRING 0.
failure $VERSION $ERROR_VERSION_STRING 0.0
failure $VERSION $ERROR_VERSION_STRING .0.0
failure $VERSION $ERROR_VERSION_STRING 0.0.
failure $VERSION $ERROR_VERSION_STRING .0.0.0
failure $VERSION $ERROR_VERSION_STRING 0.0.0.
failure $VERSION $ERROR_VERSION_STRING foo.0.0
failure $VERSION $ERROR_VERSION_STRING 0.foo.0
failure $VERSION $ERROR_VERSION_STRING 0.0.foo

failure $VERSION $ERROR_PART_FLAG 0.0.0 --foo
failure $VERSION $ERROR_PART_FLAG 0.0.0 -f
failure $VERSION $ERROR_PART_FLAG --foo 0.0.0
failure $VERSION $ERROR_PART_FLAG -f 0.0.0

. $VERSION

success version 0.0.1 0.0.0 build
success version 0.1.0 0.0.0 minor
success version 1.0.0 0.0.0 major

failure version $ERROR_VERSION_STRING
failure version $ERROR_VERSION_STRING ''
failure version $ERROR_VERSION_STRING 0
failure version $ERROR_VERSION_STRING .0
failure version $ERROR_VERSION_STRING 0.
failure version $ERROR_VERSION_STRING 0.0
failure version $ERROR_VERSION_STRING .0.0
failure version $ERROR_VERSION_STRING 0.0.
failure version $ERROR_VERSION_STRING .0.0.0
failure version $ERROR_VERSION_STRING 0.0.0.
failure version $ERROR_VERSION_STRING foo.0.0
failure version $ERROR_VERSION_STRING 0.foo.0
failure version $ERROR_VERSION_STRING 0.0.foo

failure version $ERROR_PART_FLAG 0.0.0 foo
