#!/bin/bash

## STATE can be "FAILED", "INPROGRESS" or "SUCCESSFUL"

## BITRISE_BUILD_STATUS
##     The current status of the build. The available options are:
##        Not finished (0)
##        Successful (1)
##        Failed (2)
##        Aborted with failure (3)
##        Aborted with success (4)

case $BITRISE_BUILD_STATUS in

  0)
    STATE="INPROGRESS"
    ;;

  1)
    STATE="SUCCESSFUL"
    ;;

  *)
    STATE="FAILED"
    ;;
esac

## Request
curl -X "POST" "https://bitbucket-dev.glb.syfbank.com/rest/build-status/1.0/commits/${BITRISE_GIT_COMMIT}" \
-H 'Content-Type: application/json' \
-d $'{
"state": "${STATE}",
"key": "syb-ios-ignite",
"name": "$BITRISE_GIT_BRANCH",
"url": "${BITRISE_BUILD_URL}",
"description": "$BITRISE_GIT_MESSAGE"
}'
