module Slack
  class Api
    POST_MESSAGE_PATH = "api/chat.postMessage"
    GET_USERS_PATH = "api/users.list"

    attr_reader :client

    def initialize
      @client = Client.new
    end

    def send_message
      message = client.post(
        path:   POST_MESSAGE_PATH,
        header: "application/x-www-form-urlencoded",
        options: {
                   token: ENV.fetch("SLACK_BOT_TOKEN"),
                   channel: "#general",
                   text: 'Hi!',
                   as_user: true,
                 }
      )
    end
  end
end
