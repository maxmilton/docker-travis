# Run the travis CLI via a container
#
# Build image:
#   docker build -t local/travis .
#
# Update:
#   docker build --no-cache -t local/travis .
#

FROM ruby:alpine@sha256:c88ee0877e44f95dcf7cfaace673e1174c9e9e1e2fb32b1ce0f97979568a6fd7

RUN set -xe \
  && apk add --no-cache --virtual .build-deps \
    build-base \
  && apk add --no-cache git \
  && gem install travis --no-rdoc --no-ri \
  && apk del .build-deps \
  # unset SUID on all files
  && for i in $(find / -perm /6000 -type f); do chmod a-s $i; done

WORKDIR project

ENTRYPOINT ["travis"]
