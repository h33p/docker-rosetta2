FROM alpine

COPY rosetta /bin/rosetta

COPY install.sh /install.sh

ENTRYPOINT "/install.sh"
