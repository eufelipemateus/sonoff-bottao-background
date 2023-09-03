#!/bin/sh

# Quick start-stop-daemon example, derived from Debian /etc/init.d/ssh
set -e

# Must be a valid filename
NAME=sonoff
PIDFILE=/var/run/$NAME/$NAME.pid
#This is the command to be run, give the full pathname
CHROOT=/etc/$NAME
DAEMON=/usr/local/bin/$NAME
DAEMON_OPTS="--baz=quux"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
      start)
            echo -n "Starting daemon: "$NAME
            start-stop-daemon --start --quiet --pidfile $PIDFILE  --chdir $CHROOT  --exec $DAEMON  -- $DAEMON_OPTS
            echo "."
            ;;
      stop)
            echo -n "Stopping daemon: "$NAME
            start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE
            echo "."
            ;;
      restart)
            echo -n "Restarting daemon: "$NAME
            start-stop-daemon --stop --quiet --oknodo --retry 30 --pidfile $PIDFILE
            start-stop-daemon --start --quiet --pidfile $PIDFILE  --chdir $CHROOT --exec $DAEMON -- $DAEMON_OPTS
            echo "."
            ;;

      *)
            echo "Usage: "$1" {start|stop|restart}"
            exit 1
esac

exit 0