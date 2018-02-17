module Slack
  class Api 
    class Response
      def self.parse(response_body)
        JSON.parse(response_body)
      end
    end
  end
end
