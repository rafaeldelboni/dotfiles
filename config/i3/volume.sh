#!/usr/bin/env bash

while getopts u:d:m option
do
  case "${option}"
    in
    u) $(amixer -q sset Master 5%+);;
    d) $(amixer -q sset Master 5%-);;
    m) $(amixer -q sset Master toggle);;
  esac
done
