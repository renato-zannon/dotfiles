#!/usr/bin/env sh

start_if_not_running() {
  pidof "$1" 1>/dev/null

  if [ $? -ne 0 ]; then
    if [ -n "$2" ]; then
      eval $2 &
    else
      eval $1 &
    fi
  fi
}

start_if_not_running "xbindkeys"

start_if_not_running "mpd" "mpd && mpc stop"
start_if_not_running "mpdscribble"

start_if_not_running "xcompmgr" "xcompmgr -n"
