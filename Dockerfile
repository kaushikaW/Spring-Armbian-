FROM ubuntu:latest
LABEL authors="sandu"

ENTRYPOINT ["top", "-b"]