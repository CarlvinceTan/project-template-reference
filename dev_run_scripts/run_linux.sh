#!/bin/bash

# New GNOME Terminal window for build_runner
gnome-terminal -- bash -c "flutter pub run build_runner watch --delete-conflicting-outputs; exec bash"

# Run flutter in current terminal
flutter run
