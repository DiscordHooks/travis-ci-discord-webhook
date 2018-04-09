# Travis CI 🡒 Discord Webhook

If you are looking for a way to get build (success/fail) status reports from
[Travis CI](https://travis-ci.com) in [Discord](https://discordapp.com), stop
looking. You've came to the right place.

I was waiting for the Travis team for a long time to integrate [Discord Webhook](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)
support to their build notifications, but they don't seem to be doing anything
about that. So I made these script to just do the same.

No need to wait for them to add Discord Webhook Integration, rest aside and
just follow the guide below and stay notified of your build status.

## Requirements
-  You should be using Travis CI for testing codes.
-  A Discord Server where notifications will be posted.
-  5 minutes
-  A cup of coffee ☕

## Guide
1.  Create a webhook in your Discord Server ([Guide](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)).

1.  Copy the **Webhook URL**.

1.  Go to your repository settings (for which you want status notifications)
    in Travis CI and add an environment variable called `WEBHOOK_URL` and paste
    the **Webhook URL** you got in the previous step.

    ![Add environment variable in Travis CI](https://i.imgur.com/UfXIoZn.png)

1.  Add these lines to the `.travis.yml` file of your repository.

    ```yaml
    after_success:
      - wget https://raw.githubusercontent.com/k3rn31p4nic/travis-ci-discord-webhook/master/send.sh
      - chmod +x send.sh
      - ./send.sh success $WEBHOOK_URL
    after_failure:
      - wget https://raw.githubusercontent.com/k3rn31p4nic/travis-ci-discord-webhook/master/send.sh
      - chmod +x send.sh
      - ./send.sh failure $WEBHOOK_URL
    ```

1.  Grab your coffee ☕ and enjoy! And, if you liked this, please ⭐**Star**
    this repository to show your love.

### Note
-  If you face any issues in the scripts (and you're sure it's not on your side),
please consider opening an issue and I'll fix it ASAP.
-  If you want to improve the scripts, feel free to open a pull request.

### See Also
-  [AppVeyor -> Discord Webhook](https://github.com/k3rn31p4nic/appveyor-discord-webhook)
