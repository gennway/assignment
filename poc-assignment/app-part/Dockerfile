FROM golang:alpine

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o main .

EXPOSE 8080 9000

## could be also set on task-definition level
CMD ["./app"]   

