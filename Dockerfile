# Run the travis CLI via a container
#
# Build image:
#   docker build -t local/travis .
#
# Update:
#   docker build --no-cache -t local/travis .
#

FROM ruby:alpine@sha256:f1dbca0f5dbc926eccc000967c6b09a441d1808f36b15fde4ae621124c2d3bb4

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
