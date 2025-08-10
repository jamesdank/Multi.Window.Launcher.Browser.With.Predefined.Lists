#!/bin/bash
# =========================
# Linux Browser Multi-Window Launcher
# Opens multiple windows, one per site list, in the same workspace
# =========================

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

# ---- Define your site lists (one window per list) ----
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

# =========================
# Do not edit below
# =========================

if [ -z "${BROWSER:-}" ]; then
  echo "ERROR: You must uncomment and set the BROWSER path at the top of this script."
  exit 1
fi

if ! command -v "$BROWSER" >/dev/null 2>&1; then
  if [ ! -x "$BROWSER" ]; then
    echo "ERROR: Browser not found or not executable at: $BROWSER"
    exit 1
  fi
fi

# Loop through LIST variables dynamically
for varname in LIST1 LIST2 LIST3; do
  declare -n SITES_REF="$varname"
  if [ "${#SITES_REF[@]}" -eq 0 ]; then
    continue
  fi

  echo "Opening window for $varname (${#SITES_REF[@]} tabs)"
  "$BROWSER" --new-window "${BROWSER_ARGS[@]}" "${SITES_REF[@]}" >/dev/null 2>&1 &
  sleep 0.7
done

wait -n 2>/dev/null || true
