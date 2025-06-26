import pytest
import tempfile
import shutil
from pathlib import Path

# In a real project, this fixture would be located in a file like:
# ./tests/fixtures/temp_dir_fixture.py
# and could be imported and used by multiple test modules.

@pytest.fixture(scope="module")
def temp_dir_fixture():
    """
    This fixture runs once per module.
    It creates a temporary directory for test artifacts and yields its path.
    After the tests in the module have run, it cleans up the temporary directory.
    """
    # Setup: create a temporary directory
    temp_dir = tempfile.mkdtemp(prefix="test_fixture_")
    
    yield Path(temp_dir)
    
    # Teardown: clean up the temporary directory
    shutil.rmtree(temp_dir) 