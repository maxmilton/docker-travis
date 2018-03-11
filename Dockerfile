# Run the travis CLI via a container
#
# Build image:
#   docker build -t local/travis .
#
# Update:
#   docker build --no-cache -t local/travis .
#

FROM ruby:alpine

RUN set -xe \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    git \
  && gem install travis \
  && gem install travis-lint \
  && apk del .build-deps \
  # && mkdir project \
  # unset SUID on all files
  && for i in $(find / -perm /6000 -type f); do chmod a-s $i; done

# VOLUME ["/project"]

WORKDIR project

ENTRYPOINT ["travis"]
