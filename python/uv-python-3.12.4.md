# Python 3.12.4 Environment

## Creating a Python 3.12.4 Virtual Environment with uv

To create a Python 3.12.4 virtual environment using `uv`, run:

```bash
uv python install 3.12.4 && uv venv --python 3.12.4
```

Alternatively, if Python 3.12.4 is already installed on your system:

```bash
uv venv --python 3.12.4
```

## Activating the Virtual Environment

After creating the virtual environment, activate it:

```bash
source .venv/bin/activate
```

## Deactivating the Virtual Environment

To deactivate the virtual environment:

```bash
deactivate
```

## Installing Dependencies

To install pytest and pytest-asyncio:

```bash
uv pip install pytest pytest-asyncio pytest-cov pytest-timeout pytest-sugar
```

