FROM golang:1.27 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o go-health .

FROM alpine:latest

COPY --from=builder /app/go-health /go-health

EXPOSE 8080

CMD ["/go-health"]