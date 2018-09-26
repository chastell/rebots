# frozen_string_literal: true

module Toggl
  class Api
    class Client
      URL      = "https://www.toggl.com"
      PASSWORD = "api_token"

      def initialize(token)
        @client = Faraday.new(url: URL)
        @client.basic_auth(token, PASSWORD)
      end

      def get(path:)
        response = @client.get(path)

        Response.parse(response)
      end
    end
  end
end
