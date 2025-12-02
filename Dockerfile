FROM nginx:alpine

RUN apk update && apk add --no-cache curl

COPY ./web/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]