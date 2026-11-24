#!/bin/sh
# Called by Noctalia's battery_percentage_changed hook. Forwards level + state to Nagi,
# which decides whether crossing 20% / 10% is worth a comment.
case "$NOCTALIA_BATTERY_STATE" in
  charging|fully_charged|pending_charge) charging=charging ;;
  *) charging=not-charging ;;
esac
exec ~/.local/bin/nagi emit battery "${NOCTALIA_BATTERY_PERCENT}:${charging}"
