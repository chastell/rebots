# frozen_string_literal: true

module Toggl
  class Api < Base
    WEEKLY_REPORT_PATH = "/reports/api/v2/weekly"
    ADMIN_DETAILS_PATH = "/api/v8/me"
    WORKSPACE_USERS_PATH = '/api/v8/workspaces'
    USER_AGENT = "rebot"

    attr_reader :client

    def initialize
      @client = Client.new(ENV["TOGGL_API_TOKEN"])
    end


    def users_without_entries
      get_weekly_report
        .map { |report| Toggl::Report.call(user: report["title"]["user"], entries_summary: report["totals"]) }
          .reject { |report| report[:entries_summary].empty? }
    end

    def users
      get_users.map { |user| { name: user["fullname"], email: user["email"] } }
    end

    private

    def get_users
      client.get(path: WORKSPACE_USERS_PATH +
                       "/#{workspace_id}/" +
                       "users"
                )
    end

    def get_weekly_report
      client.get(path: WEEKLY_REPORT_PATH +
                       "?" +
                       "workspace_id=#{workspace_id}" +
                       "&" + 
                       "user_agent=#{USER_AGENT}" + 
                       "&" + 
                       "grouping=users" +
                       "&" + 
                       "since=#{(Time.now - SEVEN_DAYS_IN_SECONDS)}"
      )["data"]
    end

    def workspace_id
      @workspace_id ||= client.get(path: ADMIN_DETAILS_PATH).fetch("data").dig("default_wid")
    end
  end
end
