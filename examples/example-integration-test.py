import os
import subprocess
import pytest
from pathlib import Path

# In a real project, this test file would be located at:
# ./tests/test_integration_example.py
# The script it tests would be in a location like 'src/workflows' or 'src/scripts'

# It's recommended to add the project root to PYTHONPATH.
# The integration test runner script usually handles this.
# e.g., in .cursor/examples/example-integration-test.sh
try:
    from cursor.examples.example_fixture import temp_dir_fixture
except ImportError:
    # If running locally or in an environment where PYTHONPATH isn't set,
    # we might need to adjust the sys.path. For this example, we assume
    # the test runner script handles it. If you have issues, ensure
    # the project root is in your PYTHONPATH.
    pytest.skip("Skipping test, could not import fixture. Ensure project root is in PYTHONPATH.", allow_module_level=True)


# This is the script that will be tested.
SCRIPT_UNDER_TEST = ".cursor/examples/example-script.py"


def test_integration_example_script(temp_dir_fixture):
    """
    Tests the primary functionality of the example script.

    This single integration test verifies that the script can:
    1. Execute without errors.
    2. Correctly parse arguments.
    3. Create an output file with the expected content.

    This approach follows the one-function-per-file principle for integration tests.
    """
    # Arrange
    output_filename = "test_output.txt"
    # The `temp_dir_fixture` is imported and passed by pytest.
    output_filepath = temp_dir_fixture / output_filename
    argument_value = "hello_world"
    
    command = [
        "python", 
        SCRIPT_UNDER_TEST,
        "--output-file", str(output_filepath),
        "--some-argument", argument_value
    ]

    # Act
    result = subprocess.run(
        command,
        capture_output=True,
        text=True,
        check=False
    )

    # Assert
    # 1. Check for successful execution
    assert result.returncode == 0, f"Script failed with stderr:\\n{result.stderr}"
    assert "Successfully created output file" in result.stdout
    
    # 2. Verify the file was created and has the correct content
    assert output_filepath.is_file()
    with open(output_filepath, "r") as f:
        content = f.read()
        assert "This is an example output file." in content
        assert f"Generated with argument: {argument_value}" in content
        # A more robust test might check the number of lines or specific values.
        assert len(content.strip().split('\\n')) > 1
