FROM nginx

RUN  apt-get update \ 
  && apt-get install -y nginx

