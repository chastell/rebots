module Rebot
  class Users
    class WithoutEntries
      attr_reader :all_users

      def initialize
        @all_users = Users::All.call
      end

      def self.call
        new.call
      end

      def call
        (with_missing_entries + with_no_entries + all_users)
          .group_by { |data| data[:name] }.values
            .select { |data| data.size > 1 }.map { |data| data.reduce(&:merge) }
      end

      private

      def with_weekly_report
        @users_with_missing_entries ||= Toggl::Api.new.users_with_weekly_report
      end

      def with_missing_entries
        with_weekly_report.reject { |report| report[:entries_summary].empty? }
      end

      def without_weekly_report
        @without_weekly_report ||= (all_users + with_weekly_report).group_by { |data| data[:name] }.values
          .select { |data| data.size == 1 }.map { |data| data.reduce(&:merge) }
      end

      def with_no_entries
        without_weekly_report.map { |user| Toggl::Report.call(user: user[:name], entries_summary: Hash.new) }
      end
    end
  end
end
