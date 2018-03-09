module Rebot
  class Message
    attr_reader :users

    def call
        users_data.to_json
    end

    def initialize(users:)
      @users = users
    end

    def self.call(users:)
      new(users: users).call
    end

    private

    def users_data
      users.map do |user|
        {
          text:      "_#{user[:name]}_: #{user[:entries_summary].keys.join(", ")}",
          mrkdwn_in: ["text"]
        }
      end
    end
  end
end
