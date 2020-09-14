import logging

import pytest

LOGGER = logging.getLogger(__name__)


@pytest.mark.parametrize(
    "name,command",
    [
        (
            "Hello world",
            "import torch;print(torch.cuda.is_available())",
        ),
        (
            "rand",
            "import torch;print(torch.rand(5,3))",
        ),
    ],
)
def test_torch(container, name, command):
    """Basic torch tests"""
    LOGGER.info(f"Testing torch: {name} ...")

    c = container.run(tty=True, command=["start.sh", "python", "-c", command])
    rv = c.wait(timeout=30)

    assert rv == 0 or rv["StatusCode"] == 0
    logs = c.logs(stdout=True).decode("utf-8")

    LOGGER.debug(logs)
