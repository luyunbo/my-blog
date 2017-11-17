# 后台程序操作脚本模板

参考连接：<http://fqk.io/php-task-daemon/>

后台程序的启动、停止和重启操作脚本
<!-- more -->

```shell
#!/bin/bash

__FILE__="$0"
REAL_FILE=`readlink "${__FILE__}"`
if [ ! -z "${REAL_FILE}" ]; then
    __FILE__="${REAL_FILE}"
fi

__DIR__=`cd "$(dirname "${__FILE__}")"; pwd`

RUNDIR="${__DIR__}"
EXECCMD="run XXX"
PIDFILE="${RUNDIR}/XXX.pid"
LOGFILE="${RUNDIR}/XXX.log"
TASKNAME="XXX"

if [ ! -f "${PHPFILE}" ]; then
    echo 'Missing the task file'
    exit
fi

get_pid() {
    if [ -f ${PIDFILE} ]; then
        cat ${PIDFILE}
    fi
}

start() {
    local PID=$(get_pid)
    if [ ! -z ${PID} ]; then
        echo "The ${TASKNAME}(${PID}) is running."
        echo "You should stop it before you start."
        return
    fi

    touch ${PIDFILE}

    echo "Starting ${TASKNAME}..."
    nohup ${EXECCMD} >>${LOGFILE} 2>&1 &
    echo $! > ${PIDFILE}
}

stop() {
    local PID=$(get_pid)
    if [ -z ${PID} ]; then
        echo "${TASKNAME} is not running."
        return
    fi

    echo "Stopping ${TASKNAME}..."
    get_pid | xargs kill -9
    rm -f ${PIDFILE}
}

status() {
    local PID=$(get_pid)
    if [ ! -z ${PID} ]; then
        echo "${TASKNAME}(${PID}) is running."
    else
        echo "${TASKNAME} is not running."
    fi
}

case "$1" in
    start)
        start
        ;;

    stop)
        stop
        ;;

    restart)
        stop
        start
        ;;

    status)
        status
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

exit 0
```
