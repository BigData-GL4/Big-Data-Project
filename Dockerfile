FROM ubuntu:latest
LABEL authors="nadam"


ENTRYPOINT ["top", "-b"]