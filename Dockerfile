# Start from the official n8n image, which is based on Alpine Linux
FROM n8nio/n8n:latest

# It's good practice to label your custom image
LABEL maintainer="Your Name"
LABEL description="Custom n8n image with additional Python libraries for PDF processing."

# --- The Final, Guaranteed Configuration ---
# Set the python executable path
ENV N8N_PYTHON_EXECUTABLE=/usr/bin/python3
# Create a custom directory for our packages and add it to the PYTHONPATH
# This forces n8n's sandboxed python to find our modules.
ENV PYTHONPATH=/opt/n8n-python-packages

# Switch to the root user to get permissions to install packages
USER root

# 1. Use Alpine's package manager 'apk' to add python, pip, and build tools.
RUN apk add --update --no-cache python3 py3-pip build-base jpeg-dev zlib-dev

# 2. Create our custom packages directory and give the 'node' user ownership
RUN mkdir /opt/n8n-python-packages && chown node:node /opt/n8n-python-packages

# 3. Copy the requirements file from your repository into the Docker image
COPY requirements.txt .

# 4. Now that pip is installed, install packages to our custom target directory.
#    This bypasses the system environment entirely.
RUN pip3 install --no-cache-dir --target=/opt/n8n-python-packages -r requirements.txt

# 5. (Optional but good practice) Clean up build dependencies to keep the image small.
RUN apk del build-base

# 6. Clean up the requirements file.
RUN rm requirements.txt

# IMPORTANT: Switch back to the default, non-root 'node' user that n8n runs as
USER node
