FROM node:10.14.2-slim
#Control
#Version 1.5

ENV TZ=Asia/Taipai

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /workspace

# install hexo
RUN yarn global add hexo && \
    hexo init blog && \
    cd blog && \
    npm install -g hexagon-cli

WORKDIR /workspace/blog

COPY init.sh /script/

RUN chmod +x /script/init.sh

VOLUME  ["/workspace"]

# run hexo server
# CMD ["hexo", "server","-i","0.0.0.0"]
CMD /script/init.sh
