# Run the travis CLI via a container
#
# Build image:
#   docker build -t local/travis .
#
# Update:
#   docker build --no-cache -t local/travis .
#

FROM ruby:alpine@sha256:15e425d2b978927772ec0657050cd3052e2b5d444dc599794e145ad0b9b01cda

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
