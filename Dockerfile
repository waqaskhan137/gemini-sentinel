FROM node:22-alpine

# Install System Security Tools
RUN apk add --no-cache     bash     trivy     rkhunter     aide     docker-cli     curl

# Install Gemini CLI (Global)
RUN npm install -g @google/gemini-cli

WORKDIR /app
