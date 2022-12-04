FROM node:19-alpine3.15
RUN apk add git && \
    git clone https://github.com/ZainPathan/Searchable-Product-Filter.git && \
    cd Searchable-Product-Filter && \
    npm install
WORKDIR /Searchable-Product-Filter
CMD [ "npm", "start", "--host", "0.0.0.0" ]