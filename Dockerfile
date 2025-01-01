# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy all scripts and files into /app
COPY . /app
WORKDIR /app

# Install required Python packages (if any)
RUN if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi

# Ensure scripts have execute permissions
RUN find /app -type f -name "*.sh" -exec chmod +x {} +

# Explicitly set the shell and entrypoint
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "/app/run_all.sh"]

