##### Stage 1 #####

FROM golang:alpine as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

ENV GOPROXY https://proxy.golang.org,direct

RUN go mod download

COPY . .

ENV CGO_ENABLED=0

RUN GOOS=linux go build ./app.go

##### Stage 2 #####

FROM scratch

WORKDIR /app
COPY --from=builder /app/app .

CMD ["/app/app"]