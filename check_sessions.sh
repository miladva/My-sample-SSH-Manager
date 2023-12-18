#!/bin/bash

# Maximum number of SSH sessions.
MAX_SESSIONS=10

# Counting only unique SSH connections, not sessions.
# This counts the number of unique IP addresses connected via SSH.
CURRENT_SESSIONS=$(ss -tnp | grep sshd | grep -Po '(?<=src=)[\d.]+:\d+' | sort -u | wc -l)

# Check if the current number of sessions is less than the maximum
if [ "$CURRENT_SESSIONS" -lt "$MAX_SESSIONS" ]; then
    # Allow the session to proceed
    if [ -n "$SSH_ORIGINAL_COMMAND" ]; then
        exec $SSH_ORIGINAL_COMMAND
    else
        exec $SHELL
    fi
else
    # Deny the session
    echo "Maximum number of SSH sessions reached."
    exit 1
fi
