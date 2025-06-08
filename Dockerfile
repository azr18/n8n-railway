# Start from the official n8n image. You can use a specific version if needed.
FROM n8nio/n8n:latest

# It's good practice to label your custom image
LABEL maintainer="Your Name"
LABEL description="Custom n8n image with additional Python libraries for PDF processing."

# --- Force the configuration directly into the image ---
# This makes the settings part of the container itself.
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_PYTHON_EXECUTABLE=/usr/local/bin/python
# --- End of forced configuration ---

# Switch to the root user to get permissions to install packages
USER root

# Copy the requirements file from your repository into the Docker image
COPY requirements.txt .

# Run the pip install command to install all libraries listed in the file
RUN pip install -r requirements.txt --no-cache-dir

# Clean up by removing the requirements file after installation
RUN rm requirements.txt

# IMPORTANT: Switch back to the default, non-root 'node' user that n8n runs as
USER node
