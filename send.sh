#!/bin/bash

case $1 in
  "building" )
    EMBED_COLOR=15105570
    STATUS_MESSAGE="Building"
    AVATAR="https://travis-ci.com/images/logos/TravisCI-Mascot-red.png"
    ;;

  "success" )
    EMBED_COLOR=3066993
    STATUS_MESSAGE="Passed"
    AVATAR="https://travis-ci.com/images/logos/TravisCI-Mascot-blue.png"
    ;;

  "failure" )
    EMBED_COLOR=15158332
    STATUS_MESSAGE="Failed"
    AVATAR="https://travis-ci.com/images/logos/TravisCI-Mascot-red.png"
    ;;

  * )
    EMBED_COLOR=0
    STATUS_MESSAGE="Status Unknown"
    AVATAR="https://travis-ci.com/images/logos/TravisCI-Mascot-1.png"
    ;;
esac

shift

if [ $# -lt 1 ]; then
  echo -e "WARNING!!\nYou need to pass the WEBHOOK_URL environment variable as the second argument to this script.\nFor details & guide, visit: https://github.com/DiscordHooks/travis-ci-discord-webhook" && exit
fi

AUTHOR_NAME="$(git log -1 "$TRAVIS_COMMIT" --pretty="%aN")"
COMMITTER_NAME="$(git log -1 "$TRAVIS_COMMIT" --pretty="%cN")"
COMMIT_SUBJECT="$(git log -1 "$TRAVIS_COMMIT" --pretty="%s")"
COMMIT_MESSAGE="$(git log -1 "$TRAVIS_COMMIT" --pretty="%b")" | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g'

if [ ${#COMMIT_SUBJECT} -gt 256 ]; then
  COMMIT_SUBJECT="$(echo "$COMMIT_SUBJECT" | cut -c 1-253)"
  COMMIT_SUBJECT+="..."
fi

if [ -n $COMMIT_MESSAGE ] && [ ${#COMMIT_MESSAGE} -gt 1900 ]; then
  COMMIT_MESSAGE="$(echo "$COMMIT_MESSAGE" | cut -c 1-1900)"
  COMMIT_MESSAGE+="..."
fi

if [ "$AUTHOR_NAME" == "$COMMITTER_NAME" ]; then
  CREDITS="$AUTHOR_NAME authored & committed"
else
  CREDITS="$AUTHOR_NAME authored & $COMMITTER_NAME committed"
fi

if [[ $TRAVIS_PULL_REQUEST != false ]]; then
  URL="https://github.com/$TRAVIS_REPO_SLUG/pull/$TRAVIS_PULL_REQUEST"
else
  URL=""
fi

TIMESTAMP=$(date -u +%FT%TZ)
WEBHOOK_DATA='{
  "username": "",
  "avatar_url": "https://travis-ci.com/images/logos/TravisCI-Mascot-1.png",
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Job #'"$TRAVIS_JOB_NUMBER"' (Build #'"$TRAVIS_BUILD_NUMBER"') '"$STATUS_MESSAGE"' - '"$TRAVIS_REPO_SLUG"'",
      "url": "'"$TRAVIS_BUILD_WEB_URL"'",
      "icon_url": "'$AVATAR'"
    },
    "title": "'"$COMMIT_SUBJECT"'",
    "url": "'"$URL"'",
    "description": "'"${COMMIT_MESSAGE//$'\n'/ }"\\n\\n"$CREDITS"'",
    "fields": [
      {
        "name": "Commit",
        "value": "'"[\`${TRAVIS_COMMIT:0:7}\`](https://github.com/$TRAVIS_REPO_SLUG/commit/$TRAVIS_COMMIT)"'",
        "inline": true
      },
      {
        "name": "Branch",
        "value": "'"[\`$TRAVIS_BRANCH\`](https://github.com/$TRAVIS_REPO_SLUG/tree/$TRAVIS_BRANCH)"'",
        "inline": true
      }
    ],
    "timestamp": "'"$TIMESTAMP"'"
  } ]
}'

for ARG in "$@"; do
  echo -e "[Webhook]: Sending webhook to Discord...\\n";

  (curl --fail --progress-bar -A "TravisCI-Webhook" -H Content-Type:application/json -H X-Author:k3rn31p4nic#8383 -d "${WEBHOOK_DATA//	/ }" "$ARG" \
  && echo -e "\\n[Webhook]: Successfully sent the webhook.") || echo -e "\\n[Webhook]: Unable to send webhook."
done
