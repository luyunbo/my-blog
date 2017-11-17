#!/bin/bash

__FILE__="$0"
REAL_FILE=`readlink "${__FILE__}"`
if [ ! -z "${REAL_FILE}" ]; then
    __FILE__="${REAL_FILE}"
fi

__DIR__=`cd "$(dirname "${__FILE__}")"; pwd`


new_blog=${__DIR__}/_blog/untitled.md
touch ${new_blog}
echo "has new blog: ${new_blog}"
open ${new_blog}
