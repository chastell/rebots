module Toggl
  class Api
    class Response

      def self.parse(response)
        raise UnknownTogglError.new("Unexpected Toggl API status code: #{response.status}") unless response.success?
        JSON.parse(response.body)
      end
    end
  end
end
