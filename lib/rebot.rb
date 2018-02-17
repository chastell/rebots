require 'dotenv'
require 'faraday'

require_relative 'slack/slack_api'
require_relative 'slack/api/client'
require_relative 'slack/api/response'

Dotenv.load

module Rebot
  def perform_check
    Slack::Api.new.send_message
  end

  module_function(*%i[perform_check])
end

Rebot.perform_check
