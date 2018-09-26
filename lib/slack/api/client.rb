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

      def get(path:, header:, options: {})
        response = @client.get(path, options) do |request|
          request.headers = header unless header.empty?
        end

        Response.parse(response.body)
      end

      def post(path:, header:, options: {})
        response = @client.post(path) do |request|
          request.headers = header unless header.empty?
          request.body                    = options unless options.empty?
        end

        Response.parse(response.body)
      end
    end
  end
end
