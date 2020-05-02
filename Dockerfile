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
