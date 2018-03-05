module Toggl
  class Api
    class Response

      def self.parse(response)
        case response.status
        when 200
          JSON.parse(response.body)
        else
          raise UnknownTogglError.new("Unexpected Toggl API status code: #{response.status}")
        end
      end
    end
  end
end
