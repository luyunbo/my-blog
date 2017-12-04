#!/bin/bash

__FILE__="$0"
REAL_FILE=`readlink "${__FILE__}"`
if [ ! -z "${REAL_FILE}" ]; then
    __FILE__="${REAL_FILE}"
fi

__DIR__=`cd "$(dirname "${__FILE__}")"; pwd`

blog_name='untitled.md'
if [ "$1" == "-n" ];then
    blog_name="$2".md;
fi
    

new_blog=${__DIR__}/_blog/${blog_name}
if [ ! -f ${new_blog} ]; then
    touch ${new_blog}
fi
echo "has new blog: ${new_blog}"
open ${new_blog}
