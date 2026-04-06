#!/bin/bash
# Gemini-Sentinel: Standardized Autonomous Maintenance

# 1. Configuration Check
if [ -z "$GEMINI_API_KEY" ]; then
  echo "Error: GEMINI_API_KEY is not set."
  exit 1
fi

# 2. Collect Host Context (if mounted)
DISK_STATUS=$(df -h /host | tail -n 1)
DOCKER_STATUS=$(docker ps -a --format 'table {{.Names}}\t{{.Status}}')

# 3. Formulate Autonomous Prompt
PROMPT="System context (Host mounted at /host):
Disk: $DISK_STATUS
Docker status:
$DOCKER_STATUS

Instructions:
1. Conduct system health check.
2. Run AIDE, rkhunter (filesystem security).
3. Scan images with Trivy.
4. Auto-heal: Investigate and fix any failed Docker containers.
5. Record logs and update maintenance records."

# 4. Execute Maintenance Agent
gemini -p "$PROMPT" --yolo
