#!/bin/bash

## assumes that the input 'state' variable was set by the user prior to using this Step
##
## 'state' can be "FAILED", "INPROGRESS" or "SUCCESSFUL"

## Request
curl -X "POST" "https://bitbucket-dev.glb.syfbank.com/rest/build-status/1.0/commits/${BITRISE_GIT_COMMIT}" \
-H 'Content-Type: application/json' \
-d $'{
"state": "${state}",
"key": "syb-ios-ignite",
"name": "$BITRISE_GIT_BRANCH",
"url": "${BITRISE_BUILD_URL}",
"description": "$BITRISE_GIT_MESSAGE"
}'
