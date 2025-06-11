FROM alpine:3.22

LABEL maintainer="Artic42 engineer@artic42.com"
# Install openssh
RUN apk add --no-cache openssh

# Install python and poetry
RUN apk add --no-cache python3
RUN apk add --no-cache git
RUN apk add --no-cache poetry

# Install development tools
RUN apk add --no-cache neovim
RUN apk add --no-cache gcc
RUN apk add --no-cache musl-dev
RUN apk add --no-cache lazygit
RUN apk add --no-cache tmux
RUN apk add --no-cache nushell
COPY containerFiles/tree-sitter /home/developer/bin/tree-sitter

# Copy configuration of developer tools
COPY dockerFiles/temp/NeoVim/nvim /home/developer/.config/nvim
COPY dockerFiles/temp/NeoVim/nushell /home/developer/.config/nushell
COPY dockerFiles/temp/NeoVim/tmux/tmux.conf /home/developer/.tmux.conf
COPY dockerFiles/temp/NeoVim/isGit.c /home/developer/isGit.c
RUN gcc /home/developer/isGit.c -o /home/developer/bin/isGit

# Create directory structure for bench
RUN mkdir /home/developer/workspace

# Configure ssh for user developer
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN adduser -h /home/developer -s /usr/bin/nu -D developer
RUN echo -n "developer:developer" | chpasswd
RUN chown -R developer:developer /home/developer

# Copy entrypoint script into container
COPY containerFiles/entrypoint.sh /

# Expose necssary ports
EXPOSE 22

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

