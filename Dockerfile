FROM golang:1.23-alpine AS builder

WORKDIR /app
COPY go.mod .
COPY main.go .
RUN go build -o /bin/server .

FROM alpine
COPY --from=builder /bin/server /bin/server

ENV SERVER_BIND_ADDR=":9000"
ENTRYPOINT [ "/bin/server" ]