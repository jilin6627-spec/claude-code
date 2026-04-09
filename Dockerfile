FROM node:20-bullseye-slim

ARG CLAUDE_CODE_VERSION=latest
ARG REPO_URL=https://github.com/REPLACE_ME/REPLACE_ME

ENV DEBIAN_FRONTEND=noninteractive
ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=/usr/local/share/npm-global/bin:${PATH}

LABEL org.opencontainers.image.source="${REPO_URL}"

RUN apt-get update && apt-get install -y --no-install-recommends \
 bash ca-certificates curl git jq tini zsh \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

COPY bin/claudish-linux-arm64 /usr/local/bin/claudish
RUN chmod +x /usr/local/bin/claudish

RUN mkdir -p /workspace /root/.claude
WORKDIR /workspace

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
