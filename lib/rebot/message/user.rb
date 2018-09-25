module Rebot
  class Message
    class User
      attr_reader :user

      def initialize(user:)
        @user = user
      end

      def call
        {
          attachments: attachment,
          text: text,
          channel: user[:id]
        }
      end

      def self.call(user:)
        new(user: user).call
      end

      private

      def text
        "Hey, your last 7 days in Toggl is empty for the following days:"
      end

      def attachment
          [{
            text:      "_#{user[:entries_summary].keys.join(", ")}_",
            mrkdwn_in: ["text"],
          }].to_json
      end
    end
  end
end
