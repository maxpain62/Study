FROM python:3.10-bullseye
RUN git clone https://github.com/Sysnove/flask-hello-world.git &&\
    cd flask-hello-world && mv hello.py app.py &&\
    pip3 install flask
WORKDIR /flask-hello-world
EXPOSE 5000
CMD ["flask", "run", "-h", "0.0.0.0"]