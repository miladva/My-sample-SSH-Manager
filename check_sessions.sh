#!/bin/bash

# Maximum allowed SSH sessions
MAX_SESSIONS=6

# Count the current number of SSH child processes
CURRENT_SESSIONS=$(ps aux | grep sshd: | grep -v grep | wc -l)

# Check if the current number of sessions is less than the maximum
if [ "$CURRENT_SESSIONS" -lt "$MAX_SESSIONS" ] || [ -n "$SSH_ORIGINAL_COMMAND" ]; then
    # If below the limit, or if this is a non-interactive session, proceed
    if [ -n "$SSH_ORIGINAL_COMMAND" ]; then
        exec "$SSH_ORIGINAL_COMMAND"
    else
        exec "$SHELL"
    fi
else
    # If the limit is reached, deny the session and exit
    echo "Maximum number of SSH sessions ($MAX_SESSIONS) reached. Try again later."
    exit 1
fi
