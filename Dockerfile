# start from base
FROM ubuntu:latest 

LABEL maintainer="Prakhar Srivastav <prakhar@prakhar.me>"

# install system-wide deps for python and node
# RUN apt-get -yqq update
RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository universe
RUN apt-get install -yqq python
RUN apt-get update && apt-get install -y \
    python3-pip
RUN apt-get -yqq install python-dev curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -yq nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install
RUN npm run build
RUN pip3 install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python3", "./app.py" ]
