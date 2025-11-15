#!/bin/bash

uv sync
source .venv/bin/activate
chainlit run app.py -w --port 8001
