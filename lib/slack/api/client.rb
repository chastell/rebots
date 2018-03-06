# frozen_string_literal: true

module Slack
  class Api
    class Client
      URL = "https://www.slack.com"

      def initialize
        @client = Faraday.new(url: URL) do |faraday|
          faraday.request   :url_encoded
          faraday.response  :logger
          faraday.adapter   :net_http
        end
      end

      def post(path:, header:, options: {})
        @client.post(path) do |request|
          request.headers["Content-Type"] = header unless header.empty?
          request.body                    = options unless options.empty?
        end
      end
    end
  end
end
