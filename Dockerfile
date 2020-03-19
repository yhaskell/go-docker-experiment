FROM golang:1.14 as build

WORKDIR /app

COPY go.mod  /
RUN go mod download

COPY . .
RUN  CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app .
RUN chmod +x /app

FROM scratch

WORKDIR /

COPY --from=build /app /app

CMD ["/app"]
