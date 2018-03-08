module Rebot
  class Users
    class All
      attr_reader :slack_users, :toggl_users

      def initialize
        @slack_users = Slack::Api.new.users
        @toggl_users = Toggl::Api.new.users
      end

      def self.call
        new.call
      end

      def call
        (slack_users + toggl_users).group_by { |data| data[:email] }.values
          .select { |data| data.size > 1 }.map { |data| data.reduce(&:merge) }
      end
    end
  end
end
