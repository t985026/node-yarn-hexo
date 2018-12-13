FROM node:10.14.2-slim
#Version 1.30

ENV TZ=Asia/Taipai

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn git && \
    npm install -g hexo-cli

WORKDIR /workspace

# install hexo
RUN yarn global add hexo && \
    hexo init blog && \
    cd blog && \
    git clone https://github.com/iissnan/hexo-theme-next themes/next && \
    npm install --save hexo-admin

WORKDIR /workspace/blog

COPY ./_config.yml ./_config.yml

COPY ./themes/next/_config.yml ./themes/next/_config.yml

VOLUME  ["/workspace"]

# replace this with your application's default port
EXPOSE 4000

# run hexo server
CMD ["hexo", "server","-i","0.0.0.0"]
