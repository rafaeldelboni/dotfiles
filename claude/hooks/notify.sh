#!/usr/bin/env bash
# Cross-platform notification hook for Claude Code
# Works on macOS (osascript) and Linux (notify-send)

TITLE="${CLAUDE_NOTIFY_TITLE:-Claude Code}"
MESSAGE="${CLAUDE_NOTIFY_MESSAGE:-Task completed}"

case "$(uname -s)" in
  Darwin)
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Purr\""
    ;;
  Linux)
    if command -v notify-send &>/dev/null; then
      notify-send "$TITLE" "$MESSAGE"
    elif command -v kdialog &>/dev/null; then
      kdialog --passivepopup "$MESSAGE" 5 --title "$TITLE"
    else
      echo "No notification tool found. Install libnotify or kdialog." >&2
      exit 1
    fi
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac
