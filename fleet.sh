#!/usr/bin/env bash

curl -LSs "https://download.jetbrains.com/product?code=FLL&release.type=eap&platform=linux_x64" --output /tmp/fleet && chmod +x /tmp/fleet
/tmp/fleet launch workspace -- --auth=accept-everyone --publish --enableSmartMode "--projectDir=${GITPOD_REPO_ROOT}"
