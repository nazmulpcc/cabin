FROM node:alpine

# Create app directory
RUN mkdir -p /app
COPY . /app
WORKDIR /app

RUN npm install

EXPOSE 6001
CMD [ "npm", "start" ]
