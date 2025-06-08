# Start from the official n8n image (which is based on Alpine Linux).
FROM n8nio/n8n:latest

# Force the configuration directly into the image.
# We update the python executable path to where 'apk' will install it.
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_PYTHON_EXECUTABLE=/usr/bin/python3

# Switch to the root user to install system packages.
USER root

#
# The key fix from the n8n community forum:
# Use the Alpine package manager (apk) to install a full Python and pip.
#
RUN apk update && apk add --no-cache python3 py3-pip

# Copy the requirements file and set correct ownership, which is good practice.
COPY --chown=node:node requirements.txt .

# Now that pip3 is guaranteed to exist, use it to install the packages.
RUN pip3 install --no-cache-dir -r requirements.txt

# Clean up by removing the requirements file after installation.
RUN rm requirements.txt

# IMPORTANT: Switch back to the non-root 'node' user to run n8n.
USER node
