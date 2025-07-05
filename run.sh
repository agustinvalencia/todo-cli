#!/bin/bash

# A script to run the Rust application from the project root,
# activating the correct Python virtual environment and setting
# the necessary environment variables for linking and runtime.

# --- Configuration ---
# This script assumes it is located at the top-level of your project,
# alongside the 'python' and 'rust' directories.
#
PYTHON_PROJECT_PATH="./python"
RUST_PROJECT_PATH="./rust"
# Construct an ABSOLUTE path to the Python executable
VENV_PYTHON_EXEC="$(pwd)/python/.venv/bin/python"


# --- Script ---
echo "▶️  Starting the run script..."

# 1. Check if the project directories and python executable exist
if [ ! -d "$PYTHON_PROJECT_PATH" ]; then
    echo "❌ Error: Python project directory not found at '$PYTHON_PROJECT_PATH'."
    exit 1
fi

if [ ! -d "$RUST_PROJECT_PATH" ]; then
    echo "❌ Error: Rust project directory not found at '$RUST_PROJECT_PATH'."
    exit 1
fi

if [ ! -f "$VENV_PYTHON_EXEC" ]; then
    echo "❌ Error: Python executable not found at '$VENV_PYTHON_EXEC'."
    echo "Please make sure the virtual environment has been created in the 'python' directory."
    exit 1
fi

# 2. Activate the Python virtual environment managed by uv
echo "🐍 Activating Python virtual environment..."
source "$PYTHON_PROJECT_PATH/.venv/bin/activate"

# 3. Set environment variables for PyO3 and the Rust linker
echo "🔧 Exporting PYO3_PYTHON to point to the venv interpreter..."
export PYO3_PYTHON="$VENV_PYTHON_EXEC"

# Set RUSTFLAGS using Python's built-in 'sysconfig' to find linker flags.
echo "🔧 Setting RUSTFLAGS for the linker via 'sysconfig'..."
PYTHON_LIB_DIR=$($VENV_PYTHON_EXEC -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
PYTHON_VERSION=$($VENV_PYTHON_EXEC -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
export RUSTFLAGS="-L ${PYTHON_LIB_DIR} -lpython${PYTHON_VERSION}"
echo "   RUSTFLAGS is now set to: '$RUSTFLAGS'"

# Set PYTHONHOME to tell the embedded interpreter where its standard library is.
echo "🔧 Setting PYTHONHOME for the embedded interpreter..."
PYTHON_HOME=$($VENV_PYTHON_EXEC -c "import sysconfig; print(sysconfig.get_config_var('prefix'))")
export PYTHONHOME="$PYTHON_HOME"
echo "   PYTHONHOME is now set to: '$PYTHONHOME'"

# NEW STEP: Set PYTHONPATH to tell Python where to find your 'todo' module.
# This solves the "ModuleNotFoundError: No module named 'todo'" error.
echo "🔧 Setting PYTHONPATH to include the project's source..."
export PYTHONPATH="$(pwd)/python/src"
echo "   PYTHONPATH is now set to: '$PYTHONPATH'"


# 4. Run the Rust application using Cargo
# We use --manifest-path to tell cargo where to find the project,
# since we are running the command from the root folder.
echo "🦀 Running the Rust application..."
cargo run --manifest-path "$RUST_PROJECT_PATH/Cargo.toml"

# 5. Deactivate the virtual environment
# This cleans up the environment variables and returns your shell to normal.
echo "🐍 Deactivating Python virtual environment."
deactivate

echo "✅ Script finished."



