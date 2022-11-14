FROM python:3.10-slim-bullseye
EXPOSE 5000
RUN mkdir flask-hello-world && pip3 install flask
ADD . /flask-hello-world/
RUN cd /flask-hello-world/
WORKDIR /flask-hello-world
CMD ["flask", "run", "-h", "0.0.0.0"]
