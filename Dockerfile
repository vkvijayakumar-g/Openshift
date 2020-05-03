#mentioning the version of the node
FROM node:10 

#creating the application workdirectory
WORKDIR /src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN npm install 

# Bundle app source
COPY . .

EXPOSE 8080

CMD [ "node", "server.js" ]

# Install Redis.
RUN \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

# Define mountable directories.
VOLUME ["src/data"]


# Define working directory.
WORKDIR /src/data

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379