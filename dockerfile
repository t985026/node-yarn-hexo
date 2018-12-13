FROM node:6.9-slim

MAINTAINER Kamil Karczmarczyk <kkarczmarczyk@gmail.com>

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /workspace

RUN yarn global add hexo && \
    hexo init blog && \
    cd blog && \
    git clone https://github.com/iissnan/hexo-theme-next themes/next

WORKDIR /workspace/blog

CMD ["hexo server"]

EXPOSE 4000
