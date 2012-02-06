#!/usr/bin/env sh

function start_if_not_running() {
  if [ -z "$(pidof $1)" ]; then
    $1 & disown;
  fi
}

xbindkeys & disown

start_if_not_running "mpd"
mpc stop
start_if_not_running "mpdscribble"

xcompmgr -n & disown
