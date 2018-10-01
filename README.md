REBOT
======

## Development

1. Clone the repo
  ```bash
  $ git clone git@github.com:rebased/rebots.git
  ```
1. Install gems:
  ```bash
  $ bundle install
  ```
  1. Set up environment variables

 **Rebots** uses [dotenv](https://github.com/bkeepers/dotenv) to manage environment variables. Create the `.env` file by copying the example file:

  ```bash
  $ cp .env.example .env
  ```
  1. Configure Slack

  Go to [Your Apps](https://api.slack.com/apps) 
  Click on **Rebots**
  Go to application _OAuth & Permissions_
  Copy _Bot User OAuth Access Token_ to _SLACK_BOT_TOKEN_ environmental variable

   1. Configure Toggl

   Go to [Toggl profile page](https://toggl.com/app/profile).
   Copy _Toggl Api token_ (bottom of the page) to _TOGGL_API_TOKEN_ environmental variable

     _*Important!: It has to be workspace owner's token_
   

   1. Configure Harmonogram

Get an access token by making a curl request
```bash
 curl -H "Content-Type: application/vnd.api+json;charset=utf-8"  --data '{ "data": {"type": "access-token", "attributes": { "email": <my@email.com>, "password": "<my passwoed>}}}' --request POST https://api.rebased.harmonogram.rebased.pl/api/v1/access-tokens
```
  Copy received _access token_ to _HARMONOGRAM_API_TOKEN_  environmental variable

   1. Add users slack ids excluded from check separated by the pipe |
```
EXLUDED_FROM_CHECK_SLACK_IDS=U12345|23456
```

1. Add management slack ids separated by the pipe |
```
MANAGEMENT_SLACK_IDS=U99999|U66666
```
