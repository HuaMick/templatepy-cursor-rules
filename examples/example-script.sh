#!/bin/bash

# This script serves as a generic example for executable scripts in the project.
# It demonstrates best practices such as argument parsing, environment variable
# loading, and executing a Python script.

# This script must be executed from the project root directory.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---

# The Python script to be executed.
# In a real-world scenario, this would likely be a workflow or utility script
# located in the `src` directory.
PYTHON_SCRIPT_TO_RUN=".cursor/examples/example-target-script.py"

# Default values for arguments that will be passed to the Python script.
DEFAULT_ARG_VALUE="default-from-shell"
OUTPUT_FILE_PATH="data/examples/example-output.txt"


# --- Argument Parsing (from shell) ---

# This demonstrates how a shell script can have its own arguments, which can
# then be passed to the Python script.
# It uses default values if no arguments are provided to the shell script.
# Usage: ./script.sh [some_argument] [output_file]
SOME_ARGUMENT="${1:-$DEFAULT_ARG_VALUE}"
OUTPUT_FILE="${2:-$OUTPUT_FILE_PATH}"


# --- Environment Setup ---

# Load environment variables from .env file if it exists.
# This is useful for managing secrets and configuration without hardcoding them.
if [ -f .env ]; then
  echo "Loading environment variables from .env file..."
  export $(grep -v '^#' .env | xargs)
fi

# Set PYTHONPATH to include the project's root, so that imports work correctly.
export PYTHONPATH="${PYTHONPATH}:."


# --- Execution ---

echo "================================================="
echo "Running Example Script"
echo "================================================="
echo "Python Script:   ${PYTHON_SCRIPT_TO_RUN}"
echo "Argument passed: ${SOME_ARGUMENT}"
echo "Output file:     ${OUTPUT_FILE}"
echo "PYTHONPATH:      ${PYTHONPATH}"
echo "================================================="

# Create the output directory if it doesn't exist to prevent errors.
mkdir -p "$(dirname "${OUTPUT_FILE}")"

# Run the Python script with the configured arguments.
# Note the backslashes for multi-line commands.
python "${PYTHON_SCRIPT_TO_RUN}" \
  --some-argument "${SOME_ARGUMENT}" \
  --output-file "${OUTPUT_FILE}"

echo "================================================="
echo "Example Script Finished"
echo "================================================="
echo "Check the output file at: ${OUTPUT_FILE}"
