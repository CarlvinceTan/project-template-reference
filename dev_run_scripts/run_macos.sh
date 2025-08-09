#!/bin/bash

# Open build_runner in a new Terminal tab
osascript <<EOF
tell application "Terminal"
    do script "cd $(pwd) && flutter pub run build_runner watch --delete-conflicting-outputs"
end tell
EOF

# Run flutter in the current terminal
flutter run
