FROM node:10.14.2-slim
#Version 1.51

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
    git clone https://github.com/iissnan/hexo-theme-next themes/next && \
    # npm install acorn && \
    npm install -g hexagon-cli && \
    npm install --save hexo-admin && \
    # npm install hexo-generator-archive --save && \
    # npm install hexo-generator-category --save && \
    # npm install hexo-generator-fragments --save && \
    # npm install hexo-generator-index --save && \
    # npm install hexo-generator-tag --save && \
    npm install hexo-abbrlink --save && \
    npm install hexo-auto-category --save

WORKDIR /workspace/blog

COPY ./_config.yml ./_config.yml

COPY ./themes/next/_config.yml ./themes/next/_config.yml

COPY init.sh /script/

RUN chmod +x /script/init.sh

VOLUME  ["/workspace"]

# replace this with your application's default port
EXPOSE 4000

# run hexo server
# CMD ["hexo", "server","-i","0.0.0.0"]
CMD /script/init.sh
