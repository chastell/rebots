module Rebot
  class Message
    class Management
      attr_reader :users, :channel

      def initialize(users:, channel:)
        @users = users
        @channel = channel
      end

      def call
        {
          attachments: attachment,
          text: text,
          channel: channel,
        }
      end

      def self.call(users:, channel:)
        new(users: users, channel: channel).call
      end

      private

      def text
        "Hey, there were Toggl empty entries for the following users in last 7 days:"
      end

      def attachment
        users.map do |user|
          {
            text:      "_#{user[:name]}_: #{user[:entries_summary].keys.join(", ")}",
            mrkdwn_in: ["text"],
          }
        end.to_json
      end
    end
  end
end
