require "spec_helper"

describe Slack::Api::Client do
  describe "#get" do
    it "makes call to Slack API and returns parsed response" do
      stub_slack_api_get_users_request

      response = Slack::Api::Client.new.get(
        path: Slack::Api::GET_USERS_PATH,
        header: slack_api_headers
      )

      expect(response).to eq(slack_api_get_users_response_body)
    end
  end

  describe "#post" do
    it "makes call to Slack API and returns parsed response" do
      stub_slack_api_send_message_request

      response = Slack::Api::Client.new.post(
        path: Slack::Api::POST_MESSAGE_PATH,
        header: slack_api_headers
      )

      expect(response).to eq(slack_api_send_message_response_body)
    end
  end
end
 
