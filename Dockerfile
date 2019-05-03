FROM golang:alpine3.8
WORKDIR /project
RUN apk add --no-cache git
RUN go get github.com/gdamore/tcell && go get github.com/pdevine/go-asciisprite
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o tetromino *.go

ENV PATH "$PATH:/project"
COPY run_tests.sh /project
RUN chmod +x /project/run_tests.sh

FROM scratch
COPY --from=0 /project/tetromino /tetromino
CMD ["/tetromino"]
