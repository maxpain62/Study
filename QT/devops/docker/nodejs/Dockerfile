FROM node
RUN git clone https://github.com/gothinkster/angular-realworld-example-app.git && \
    cd angular-realworld-example-app && \
    npm install -g @angular/cli && \
    npm install
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]