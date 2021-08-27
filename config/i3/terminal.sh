#!/usr/bin/env bash

WINIT_X11_SCALE_FACTOR=${LOCAL_DPI_FACTOR:-1.2} alacritty -e tmux new-session
