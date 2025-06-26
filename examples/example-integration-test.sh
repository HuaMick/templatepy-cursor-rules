#!/bin/bash

# This script runs the example integration test.
# It demonstrates the standard way to execute integration tests in this project.
# This script must be executed from the project root directory.

# Exit immediately if a command exits with a non-zero status.
set -e

# Set PYTHONPATH to include the project's root, so that imports of `src` modules work correctly.
export PYTHONPATH="${PYTHONPATH}:."

# The test file to run.
# The path is relative to the project root.
TEST_FILE=".cursor/examples/example-integration-test.py"

echo "================================================="
echo "Running Example Integration Test"
echo "================================================="
echo "Test file: ${TEST_FILE}"
echo "PYTHONPATH: ${PYTHONPATH}"
echo "================================================="

# It's good practice to check if the test file exists.
if [ ! -f "${TEST_FILE}" ]; then
    echo "Error: Test file not found at ${TEST_FILE}"
    exit 1
fi

# Run pytest for the specific integration test file.
# -v for verbose output
# -s to show print statements (e.g. from logging)
python -m pytest "${TEST_FILE}" -v -s

echo "================================================="
echo "Example Integration Test Finished"
echo "=================================================" 