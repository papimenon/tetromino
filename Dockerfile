FROM golang:alpine3.7
WORKDIR /project
COPY *.go ./
RUN apk add --no-cache git
RUN go get github.com/gdamore/tcell && go get github.com/pdevine/go-asciisprite
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o tetromino *.go

FROM scratch
COPY --from=0 /project/tetromino /tetromino
CMD ["/tetromino"]
