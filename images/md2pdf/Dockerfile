FROM webera/base:latest

# Install Pandoc, LaTeX, and required fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-xetex \
    lmodern \
    fonts-liberation \
    fonts-dejavu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /data

# Copy assets including templates and entrypoint
COPY assets/ /opt/md2pdf/

# Make entrypoint executable
RUN chmod +x /opt/md2pdf/entrypoint.sh

# Set default environment variables
ENV TEMPLATE=default \
    PAPER_SIZE=letter \
    MARGIN=1in \
    FONT_SIZE=11pt

# Set entrypoint
ENTRYPOINT ["/opt/md2pdf/entrypoint.sh"]