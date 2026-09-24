FROM mcr.microsoft.com/devcontainers/base:trixie

# Set the frontend to noninteractive to configure the time zone
ARG DEBIAN_FRONTEND=noninteractive

# Switch to root user to install packages
USER root

# Install packages for building the LaTeX template.
RUN apt-get -qq update && apt-get install -y --no-install-recommends \
    make \
    ghostscript \
    texlive \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-lang-german \
    texlive-latex-extra \
    texlive-publishers \
    texlive-science \
    texlive-pstricks \
    texlive-pictures \
    texlive-extra-utils \
    biber \
    chktex \
    git \
    curl \
    wget \
    sudo \
    default-jre \
    perl-tk \
    texlive-binaries \
    latexmk \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the vscode user to avoid running container commands as root
USER vscode

# Set the working directory
WORKDIR /workspace
