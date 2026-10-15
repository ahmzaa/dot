#!/usr/bin/env bash
set -euo pipefail

# Optional argument: random date range in days.
# Default: ±365 days from now.
range_days="${1:-365}"

if ! [[ "$range_days" =~ ^[0-9]+$ ]]; then
  printf 'Usage: %s [non-negative integer number of days]\n' "$0" >&2
  exit 1
fi

fmt="%Y-%m-%d %H:%M:%S"
now="$(date +%s)"

# Detect a way to format an epoch timestamp.
# This helps the script work on both GNU/Linux and macOS/BSD.
if command -v gdate >/dev/null 2>&1; then
  date_style="gdate"
elif date -d "@0" +"$fmt" >/dev/null 2>&1; then
  date_style="gnu"
else
  date_style="bsd"
fi

print_date() {
  local epoch="$1"

  case "$date_style" in
    gdate)
      gdate -d "@$epoch" +"$fmt"
      ;;
    gnu)
      date -d "@$epoch" +"$fmt"
      ;;
    bsd)
      date -r "$epoch" +"$fmt"
      ;;
    *)
      printf 'error: no supported date implementation found\n' >&2
      return 1
      ;;
  esac
}

# Choose a random signed offset in seconds within ±range_days.
range_seconds=$(( range_days * 86400 ))

# Combine two $RANDOM values for a wider random range.
seed1="$RANDOM"
seed2="$RANDOM"
rand=$(( ((seed1 << 15) | seed2) % (2 * range_seconds + 1) ))

offset=$(( rand - range_seconds ))
random_epoch=$(( now + offset ))

current_date="$(print_date "$now")"
random_date="$(print_date "$random_epoch")"

# Time difference.
diff_seconds=$(( random_epoch - now ))
abs_seconds="${diff_seconds#-}"

if (( diff_seconds > 0 )); then
  direction="in the future"
  direction_key="future"
elif (( diff_seconds < 0 )); then
  direction="in the past"
  direction_key="past"
else
  direction="right now"
  direction_key="now"
fi

days=$(( abs_seconds / 86400 ))

pretty_unit() {
  local n="$1"
  local unit="$2"

  if (( n == 1 )); then
    printf '%s %s' "$n" "$unit"
  else
    printf '%s %ss' "$n" "$unit"
  fi
}

pretty_duration() {
  local s="$1"

  if (( s < 60 )); then
    pretty_unit "$s" "second"
  elif (( s < 3600 )); then
    pretty_unit "$(( s / 60 ))" "minute"
  elif (( s < 86400 )); then
    pretty_unit "$(( s / 3600 ))" "hour"
  else
    local d="$(( s / 86400 ))"

    if (( d < 31 )); then
      pretty_unit "$d" "day"
    elif (( d < 365 )); then
      pretty_unit "$(( d / 30 ))" "month"
    else
      pretty_unit "$(( d / 365 ))" "year"
    fi
  fi
}

if (( abs_seconds == 0 )); then
  diff_display="0 seconds"
else
  diff_display="about $(pretty_duration "$abs_seconds")"
fi

fortune() {
  local key="$1"
  local s="$2"
  local d="$3"
  local msg=""

  case "$key" in
    now)
      msg="The random date and the present moment are aligned. Today favors insight, serendipity, and small signs."
      ;;

    future)
      if (( s < 3600 )); then
        msg="A pleasant surprise is already within reach. Stay open to it in the next hour."
      elif (( s < 86400 )); then
        msg="A good moment will pass through your day. If you feel it, follow it."
      elif (( d < 3 )); then
        msg="Something enjoyable is nearby, but it will test your patience. Do not force it."
      elif (( d < 7 )); then
        msg="A positive change is coming this week. Keep your schedule flexible."
      elif (( d < 31 )); then
        msg="An opportunity is arriving with the month. Prepare a little, but do not overthink it."
      elif (( d < 365 )); then
        msg="A meaningful shift is months away. Use the time to build confidence and reduce clutter."
      else
        msg="A large fortune is far off. Plant small seeds now and trust the long game."
      fi
      ;;

    past)
      if (( s < 3600 )); then
        msg="A lucky chance slipped by moments ago. It is not a loss; it is a hint to stay alert."
      elif (( s < 86400 )); then
        msg="An earlier moment today is still echoing. Ask what it was trying to teach you."
      elif (( d < 3 )); then
        msg="A recent mistake is not final. Repair what can be repaired, then let the rest go."
      elif (( d < 7 )); then
        msg="A worry from this week has lost its power. Say the truth plainly and move on."
      elif (( d < 31 )); then
        msg="A past choice is still coloring your present. Review it kindly, then redirect your energy."
      elif (( d < 365 )); then
        msg="An old pattern has resurfaced. Name it, so it stops choosing for you."
      else
        msg="A very old lesson has finally come due. Forgive the past you, and begin again."
      fi
      ;;

    *)
      msg="The universe is being vague, but that usually means to breathe and watch closely."
      ;;
  esac

  printf '%s\n' "$msg"
}

fortune_text="$(fortune "$direction_key" "$abs_seconds" "$days")"

printf 'Current date : %s\n' "$current_date"
printf 'Random date  : %s\n' "$random_date"

if (( diff_seconds == 0 )); then
  printf 'Difference   : right now\n'
else
  printf 'Difference   : %s %s\n' "$diff_display" "$direction"
fi

printf 'Fortune      : %s\n' "$fortune_text"

