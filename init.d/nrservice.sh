#!/bin/bash
### BEGIN INIT INFO
# Provides:          nrservice
# Required-Start:    $all
# Should-Start:
# Required-Stop:
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start and Stop NeoRouter client service
# Description:       NeoRouter client service connects this computer into NeoRouter virtual network 
#                    contact support@neorouter.com
### END INIT INFO

set -e

NAME=nrservice
DAEMON=/usr/bin/$NAME

test -x $DAEMON || exit 0
. /lib/lsb/init-functions

case "$1" in
  start)
    log_begin_msg "Starting NeoRouter client service: $NAME"
    start-stop-daemon --start --background -m --pidfile /var/run/nrservice.pid --exec $DAEMON >/dev/null && log_end_msg 0 || log_end_msg 1
    ;;
  stop)
    log_begin_msg "Stopping NeoRouter client service: $NAME"
    start-stop-daemon --stop --pidfile /var/run/nrservice.pid --oknodo --exec $DAEMON && log_end_msg 0 || log_end_msg 1
    rm -f /var/run/nrservice.pid
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
    log_success_msg "Usage: /etc/init.d/$0 {start|stop|restart}"
    exit 1
    ;;
esac

exit 0
