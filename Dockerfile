FROM node:16 as dev

RUN mkdir -p /home/node/BoilerPlate
RUN chown -R node:node /home/node/BoilerPlate
WORKDIR /home/node/BoilerPlate

EXPOSE 3000

FROM dev as full

#copy package.json and package-lock.json
COPY --chown=node:node package*.json ./

#install dependencies
RUN npm install

#copy source
COPY --chown=node:node . .

# install netcat for waiter
# running this here allows the container to be run as a non-root user
RUN apt-get update && apt-get install -y netcat

USER node

RUN npm run build

CMD ["npm", "run", "start:prod"]