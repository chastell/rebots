require 'dotenv'
require 'faraday'
require 'json'
require 'sinatra'

require_relative 'rebot/users/all'
require_relative 'rebot/users/without_entries'

require_relative 'rebot/message/user'
require_relative 'rebot/message/management'

require_relative 'slack/slack_api'
require_relative 'slack/api/client'
require_relative 'slack/api/response'

require_relative 'toggl/base'
require_relative 'toggl/report'

require_relative 'toggl/toggl_api'
require_relative 'toggl/api/client'
require_relative 'toggl/api/response'

Dotenv.load

module Rebot
  UnknownTogglError = Class.new(NotImplementedError)

  def perform_check
    users_without_entries = Users::WithoutEntries.call
    return if users_without_entries.empty?

    client = Slack::Api.new

    users_without_entries.each do |user|
      unless excluded_from_check.include?(user[:id])
        client.send_message(
          options: Rebot::Message::User.call(user: user),
        )
      end
    end

    management.each do |id|
      client.send_message(
        options: Rebot::Message::Management.call(
          users: users_without_entries.delete_if { |user| excluded_from_check.include?(user[:id]) },
          channel: id,
        ),
      )
    end

    def excluded_from_check
      ENV["EXLUDED_FROM_CHECK_SLACK_IDS"].split('|')
    end

    def management
      ENV["MANAGEMENT_SLACK_IDS"].split('|')
    end
  end

  module_function(*%i[perform_check])
end
