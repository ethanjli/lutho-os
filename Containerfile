ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-aurora}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-dx}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-${BASE_IMAGE_NAME}-${IMAGE_FLAVOR}}"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-stable}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}

COPY 20-suspend-fixes.rules /usr/lib/udev/rules.d/20-suspend-fixes.rules
COPY 72-opentabletdriver-disable.rules /usr/lib/udev/rules.d/72-opentabletdriver-disable.rules
COPY logind.conf /usr/lib/systemd/logind.conf
RUN \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=bind,from=ctx,source=build.sh,target=/tmp/build.sh \
    --mount=type=bind,from=ctx,source=install-zerotier.sh,target=/tmp/install-zerotier.sh \
    /tmp/build.sh

RUN bootc container lint
