# Start from the official n8n image. You can specify a version if needed.
FROM n8nio/n8n:latest

# It's good practice to label your custom image
LABEL maintainer="Your Name"
LABEL description="Custom n8n image with additional Python libraries for PDF processing."

# Force the configuration directly into the image
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_PYTHON_EXECUTABLE=/usr/local/bin/python

# Switch to the root user to get permissions to install packages
USER root

# Copy the requirements file from your repository into the Docker image
COPY requirements.txt .

# Run the pip install command using pip3
# --no-cache-dir is a good practice to keep the image size smaller
RUN pip3 install -r requirements.txt --no-cache-dir

# Clean up by removing the requirements file after installation
RUN rm requirements.txt

# IMPORTANT: Switch back to the default, non-root 'node' user that n8n runs as
USER node
