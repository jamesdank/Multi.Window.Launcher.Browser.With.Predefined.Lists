#!/bin/bash
# ==========================================
# Linux Browser Multi-Window Launcher (Auto)
# - Opens one window per LIST# array
# - Automatically detects LIST1, LIST2, LIST3, ...
# ==========================================

# -------- SELECT YOUR BROWSER (uncomment ONE) --------
#BROWSER="/usr/bin/brave-browser"              # Brave (most distros)
#BROWSER="/opt/brave.com/brave/brave-browser"  # Brave (manual install)
#BROWSER="/usr/bin/google-chrome"              # Google Chrome
#BROWSER="/usr/bin/chromium-browser"           # Chromium (Ubuntu/Debian)
#BROWSER="/usr/bin/chromium"                   # Chromium (Arch/Fedora)
#BROWSER="/usr/bin/firefox"                    # Firefox
#BROWSER="/opt/firefox/firefox"                # Firefox (manual install)
#BROWSER="/usr/bin/microsoft-edge"             # Edge (Linux)
# -----------------------------------------------------

# Optional: extra args for Chromium-based browsers
BROWSER_ARGS=(
  # "--user-data-dir=$HOME/.config/BrowserMultiWindows"
  # "--profile-directory=Default"
)

# -------- Define your site lists (one window per list) --------
# Add as many LIST# arrays as you want: LIST1, LIST2, LIST3, ...
LIST1=(
  "https://news.ycombinator.com"
  "https://www.bbc.com"
  "https://www.reuters.com"
)

LIST2=(
  "https://github.com"
  "https://stackoverflow.com"
  "https://developer.mozilla.org"
)

LIST3=(
  "https://www.reddit.com"
  "https://twitter.com"
  "https://www.youtube.com"
)

# OPTIONAL: Per-list profile (Chromium/Brave/Chrome)
# Uncomment and set to use different profiles per window:
#PROFILE_LIST1="Default"
#PROFILE_LIST2="Work"
#PROFILE_LIST3="Social"

# ==========================================
# Do not edit below
# ==========================================

if [ -z "${BROWSER:-}" ]; then
  echo "ERROR: You must uncomment and set the BROWSER path at the top of this script."
  exit 1
fi

# Validate browser exists (either in PATH or as an executable path)
if ! command -v "$BROWSER" >/dev/null 2>&1; then
  if [ ! -x "$BROWSER" ]; then
    echo "ERROR: Browser not found or not executable at: $BROWSER"
    exit 1
  fi
fi

# Find all variables named LIST<number>, sort numerically (LIST1, LIST2, ...)
mapfile -t LIST_VARS < <(compgen -A variable | grep -E '^LIST[0-9]+$' | sort -V)

if [ "${#LIST_VARS[@]}" -eq 0 ]; then
  echo "WARNING: No LIST# arrays found (e.g., LIST1, LIST2). Nothing to open."
  exit 0
fi

for varname in "${LIST_VARS[@]}"; do
  # Get number of URLs in this list without expanding the array
  eval "COUNT=\${#$varname[@]}"
  if [ "$COUNT" -eq 0 ]; then
    echo "Skipping $varname (empty)."
    continue
  fi

  # Nameref to the list array
  declare -n SITES_REF="$varname"

  # Optional per-list profile: PROFILE_LIST#
  profile_var="PROFILE_${varname}"
  profile_arg=()
  if [ -n "${!profile_var-}" ]; then
    profile_arg=( "--profile-directory=${!profile_var}" )
  fi

  echo "Opening window for $varname ($COUNT tabs)"
  "$BROWSER" --new-window "${BROWSER_ARGS[@]}" "${profile_arg[@]}" "${SITES_REF[@]}" >/dev/null 2>&1 &
  sleep 0.7
done

# Don’t block the shell if the browser exits early
wait -n 2>/dev/null || true
