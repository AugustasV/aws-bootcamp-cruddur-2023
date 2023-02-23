# Using alpine image, in that way we make build time shorter
FROM node:16-alpine3.16

ENV PORT=3000

COPY . /frontend-react-js
WORKDIR /frontend-react-js
RUN npm install
EXPOSE ${PORT}
CMD ["npm", "start"]