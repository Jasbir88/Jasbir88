# Use the latest Ubuntu base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    python3 \
    python3-pip

# Copy all scripts and files into /app
COPY . /app
WORKDIR /app

# Install required Python packages (if any)
RUN pip3 install -r requirements.txt || true

# Ensure scripts have execute permissions
RUN chmod +x /app/*.sh

# Explicitly set the shell and entrypoint
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "/app/run_all.sh"]

