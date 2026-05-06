#!/usr/bin/env bash

# run_editor.sh
# Navigates to project folder → creates/activates venv → installs deps → runs app.py

set -euo pipefail

# ────────────────────────────────────────────────
#  Change to the correct project directory
# ────────────────────────────────────────────────

TARGET_DIR="$HOME/YOUR/LOCATION/HERE"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory not found: $TARGET_DIR"
    echo "Please check the path and try again."
    exit 1
fi

cd "$TARGET_DIR" || {
    echo "Failed to cd into $TARGET_DIR"
    exit 1
}

echo "Now running in: $(pwd)"

# ────────────────────────────────────────────────
#  Virtual environment setup
# ────────────────────────────────────────────────

VENV_DIR=".venv"

echo "Setting up virtual environment..."

if [ ! -d ".venv" ] || [ ! -f ".venv/bin/python" ] || [ ! -f ".venv/bin/activate" ]; then
    echo "Creating new virtual environment in .venv..."
    python3 -m venv ".venv" || {
        echo "Failed to create virtual environment."
        echo "Make sure 'python3 -m .venv' works on your system."
        exit 1
    }
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi

# Activate the venv
source ".venv/bin/activate"

# Install your dependencies
echo "Installing required packages (pandas, openpyxl, flask)..."
pip install  moviepy
echo "Dependencies are ready."

# Verify the main file exists
if [ ! -f "makevid.py" ]; then
    echo "Error: makevid.py not found in $(pwd)"
    deactivate
    exit 1
fi

# ────────────────────────────────────────────────
#  Launch the application
# ────────────────────────────────────────────────

echo "Launching makevid.py..."
echo "───────────────────────────────"

exec python makevid.py
# The 'exec' replaces this shell process with python → cleaner shutdown
