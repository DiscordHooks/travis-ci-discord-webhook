# Travis CI 🡒 Discord Webhook
[![Backers on Open Collective](https://opencollective.com/discordhooks/backers/badge.svg)](#backers)
 [![Sponsors on Open Collective](https://opencollective.com/discordhooks/sponsors/badge.svg)](#sponsors) 

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
      - wget https://raw.githubusercontent.com/DiscordHooks/travis-ci-discord-webhook/master/send.sh
      - chmod +x send.sh
      - ./send.sh success $WEBHOOK_URL
    after_failure:
      - wget https://raw.githubusercontent.com/DiscordHooks/travis-ci-discord-webhook/master/send.sh
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
-  [AppVeyor -> Discord Webhook](https://github.com/DiscordHooks/appveyor-discord-webhook)
-  [GitLab CI -> Discord Webhook](https://github.com/DiscordHooks/gitlab-ci-discord-webhook)

## Contributors

This project exists thanks to all the people who contribute. <img src="https://opencollective.com/DiscordHooks/contributors.svg?width=890&button=false" />


## Backers

Thank you to all our backers! 🙏 [[Become a backer](https://opencollective.com/DiscordHooks#backer)]

<a href="https://opencollective.com/DiscordHooks#backers" target="_blank"><img src="https://opencollective.com/DiscordHooks/backers.svg?width=890"></a>


## Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [[Become a sponsor](https://opencollective.com/DiscordHooks#sponsor)]

<a href="https://opencollective.com/DiscordHooks/sponsor/0/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/1/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/2/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/3/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/4/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/5/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/6/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/7/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/8/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/DiscordHooks/sponsor/9/website" target="_blank"><img src="https://opencollective.com/DiscordHooks/sponsor/9/avatar.svg"></a>
