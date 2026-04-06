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
PROMPT="Server Maintenance:
Disk: $DISK_STATUS
Docker Status:
$DOCKER_STATUS

STATUS DOCUMENT (STATUS.md):
The file 'STATUS.md' contains the persistent history. Use the format from 'STATUS_TEMPLATE.md'.

Instructions:
1. Conduct system health check on /host.
2. Run AIDE, rkhunter (scans /host).
3. Scan images with Trivy.
4. AUTO-HEAL: If any container is 'Exited' or 'Restarting', investigate logs, fix root cause (e.g. increase memory limits if OOM), and RESTART it.
5. Update STATUS.md following the structure in STATUS_TEMPLATE.md. Ensure you preserve the 'Historical Log' section, appending new entries as the document grows."

# 4. Execute Maintenance Agent
gemini -p "$PROMPT" --yolo
