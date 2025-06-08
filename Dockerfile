# Start from the official n8n image, which is based on Alpine Linux
FROM n8nio/n8n:latest

# It's good practice to label your custom image
LABEL maintainer="Your Name"
LABEL description="Custom n8n image with additional Python libraries for PDF processing."

# Force the configuration directly into the image
# Note: The python path is now /usr/bin/python3, which is standard for Alpine
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_PYTHON_EXECUTABLE=/usr/bin/python3

# Switch to the root user to get permissions to install packages
USER root

# --- The Final, Correct Method for Alpine Linux ---
# 1. Use Alpine's package manager 'apk' to add python, pip, and build tools.
#    pdfplumber's dependencies (like Pillow) need these to compile.
RUN apk add --update --no-cache python3 py3-pip build-base jpeg-dev zlib-dev

# 2. Copy the requirements file from your repository into the Docker image
COPY requirements.txt .

# 3. Now that pip is installed, use it to install the Python packages.
RUN pip3 install --no-cache-dir -r requirements.txt

# 4. (Optional but good practice) Clean up build dependencies to keep the image small.
RUN apk del build-base

# 5. Clean up the requirements file.
RUN rm requirements.txt

# IMPORTANT: Switch back to the default, non-root 'node' user that n8n runs as
USER node
