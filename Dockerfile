FROM node:10.14.2-slim
#Version 1.21 

ENV TZ=Asia/Taipai

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn git

WORKDIR /workspace

# install hexo
RUN yarn global add hexo && \
    hexo init blog && \
    cd blog && \
    git clone https://github.com/iissnan/hexo-theme-next themes/next

WORKDIR /workspace/blog

COPY _config.yml /workspace/blog/_config.yml

COPY themes/next/_config.yml /workspace/blog/themes/next/_config.yml

COPY init.sh /script/

RUN chmod +x /script/init.sh

RUN npm install -g hexo-cli

# replace this with your application's default port
EXPOSE 4000

# run hexo server
ENTRYPOINT ["/script/init.sh"]

VOLUME  ["/workspace"]
