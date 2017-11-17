#!/bin/bash
  
IFS='
'

usage ()
{
  echo 'Usage : publish -p <post_name> -t <tags> -c <categories> '
  echo 'e.g. :  publish -p hello-world.md -t hello,world -c hellow,world'
  exit
}

__FILE__="$0"
REAL_FILE=`readlink "${__FILE__}"`
if [ ! -z "${REAL_FILE}" ]; then
    __FILE__="${REAL_FILE}"
fi

__DIR__=`cd "$(dirname "${__FILE__}")"; pwd`


if [[ $# < 1 ]];then
	usage
fi 

while [[ -n "$1" ]]; do
	case "$1" in
		-p) post="$2"
			shift ;;
		-t) tags="$2"
			shift ;;
		-c) categories="$2"
			shift ;;
		*) usage
	esac
	shift
done

if [[ ! -n "$post" ]];then
	usage
fi

post=${__DIR__}/${post}

post_name=`basename ${post}`


post_public=${__DIR__}/_post/${post_name}

if [[ -f "$post_public" ]];then
    last_time=`sed -n '/date:/p' ${post_public}`
    create_time=${last_time#date:}
else
    create_time=`date "+ %Y-%m-%d %H:%M:%S"`
fi

sed "1s/#/title:/g" ${post} > ${post_public} 

sed -i '' '1a\
---
'  ${post_public}

if [ -n "${tags}" ];then
    sed -i  '' '1a\
        tags: ['${tags}']
    ' ${post_public}
fi
    
if [ -n "${categories}" ];then
    sed -i '' '1a\
        categories: ['${categories}']
    ' ${post_public}
fi

sed -i '' '1a\
date:'${create_time}'
' ${post_public}

sed -i '' '1i\
---
' ${post_public}

scp ${post_public} luyunbo.me:/var/www/luyunbo.me/blog/source/_posts/

ssh luyunbo.me "cd /var/www/luyunbo.me/blog; hexo d -g"

echo "www.luyunbo.me/${post_name/%.md/}"
