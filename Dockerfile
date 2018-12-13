FROM node:10.14.2-slim
<<<<<<< HEAD:dockerfile
#Version 1.20
=======
#Version 1.21

ENV TZ=Asia/Taipai
>>>>>>> origin/alpha:Dockerfile

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
<<<<<<< HEAD:dockerfile
    npm install --save hexo-admin-ehc && \
=======
>>>>>>> origin/alpha:Dockerfile
    git clone https://github.com/iissnan/hexo-theme-next themes/next

WORKDIR /workspace/blog

<<<<<<< HEAD:dockerfile
ADD _config.yml /workspace/blog/_config.yml

ADD themes/next/_config.yml /workspace/blog/themes/next/_config.yml
=======
COPY _config.yml /workspace/blog/_config.yml

COPY themes/next/_config.yml /workspace/blog/themes/next/_config.yml

COPY init.sh /script/

RUN chmod +x /script/init.sh

RUN npm install -g hexo-cli
>>>>>>> origin/alpha:Dockerfile

# replace this with your application's default port
EXPOSE 4000

# run hexo server
ENTRYPOINT ["/script/init.sh"]

VOLUME  ["/workspace"]
