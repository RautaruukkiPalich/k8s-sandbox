FROM golang:1.23-alpine AS builder

RUN apk update && apk --no-cache add bash git make

WORKDIR /app
# ,"go.sum"
COPY ["go.mod","./"]
RUN go mod download
COPY . .
RUN go build -o /bin/backend ./services/backend/backend.go

FROM alpine AS runner

RUN apk update
COPY --from=builder /bin/backend /bin/backend

ENV SERVER_BIND_ADDR=":2223"

ENTRYPOINT [ "/bin/backend" ]