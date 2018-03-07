# frozen_string_literal: true

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
        path:    POST_MESSAGE_PATH,
        header:  "application/x-www-form-urlencoded",
        options: {
                   token:   ENV.fetch("SLACK_BOT_TOKEN"),
                   channel: "#general",
                   text:    "Hi!",
                   as_user: true,
                 }
      )
    end

    def users
      get_users_list
        .reject { |user| user["is_bot"] }
          .map { |user| { id: user["id"], email: user["profile"]["email"] } }
    end

    private

    def get_users_list
      client.get(
        path: GET_USERS_PATH,
        header: "application/x-www-form-urlencoded",
        options: {
                   token: ENV.fetch("SLACK_BOT_TOKEN"),
                 }
        )["members"]
    end
  end
end
