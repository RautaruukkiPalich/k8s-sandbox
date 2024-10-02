FROM golang:1.23-alpine AS builder

RUN apk update && apk --no-cache add bash git make

WORKDIR /app
# ,"go.sum"
COPY ["go.mod","./"]
RUN go mod download
COPY . .
RUN go build -o /bin/api ./services/api/api.go

FROM alpine AS runner

RUN apk update
COPY --from=builder /bin/api /bin/api

ENV SERVER_BIND_ADDR=":2222"

ENTRYPOINT [ "/bin/api" ]
