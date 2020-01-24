#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
set -x

## input: bitbucket_base_url - is the base url for the bitbucket build-status update post.

## STATE can be "FAILED", "INPROGRESS" or "SUCCESSFUL"

## BITRISE_BUILD_STATUS
##     The current status of the build. The available options are:
##        Successful (0)
##        Failed (1)

case ${BITRISE_BUILD_STATUS} in
  0)
    STATE="SUCCESSFUL"
    ;;

  1)
    STATE="FAILED"
    ;;

  *)
    STATE="FAILED"
    ;;
esac

echo "Current build status: (${BITRISE_BUILD_STATUS}) $STATE"

## Request
curl -u "${svc_username}:${svc_password}" -X "POST" "https://api.syf.com/v1/bitrise/bitbucket1/rest/build-status/1.0/commits/${BITRISE_GIT_COMMIT}" \
-H 'Content-Type: application/json' \
-d "{
\"state\": \"${STATE}\",
\"key\": \"syb-ios-ignite\",
\"name\": \"$BITRISE_GIT_BRANCH\",
\"url\": \"${BITRISE_BUILD_URL}\",
\"description\": \"$BITRISE_GIT_MESSAGE\"
}"
