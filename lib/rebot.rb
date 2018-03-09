require 'dotenv'
require 'faraday'
require 'json'

require_relative 'rebot/users/all'
require_relative 'rebot/users/without_entries'
require_relative 'rebot/message'

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

    Slack::Api.new.send_message(
      text: Rebot::Message.call(users: users_without_entries),
      channel: "#general"
    )
  end

  module_function(*%i[perform_check])
end
