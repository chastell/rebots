require 'spec_helper'

describe Slack::Api do
  describe '#send_message' do
    let(:client) { double }
    let(:slack_api) { Slack::Api.new }

    before do 
      allow(slack_api).to receive(:client).and_return(client)
      allow(ENV).to receive(:fetch).with('SLACK_BOT_TOKEN').and_return('token')
    end

    it 'makes call to Slack Api and returns parsed response' do
      expect(client).to receive(:post).with(
        path: Slack::Api::POST_MESSAGE_PATH,
        header: 'application/x-www-form-urlencoded',
        options: {
          token: "token",
          channel: "#general",
          text: 'Hi!',
          as_user: true,
        }
      ).and_return(slack_send_message_response)

      expect(slack_api.send_message).to eq(      
        {
          "ok": true,
          "channel": "C1H9RESGL",
          "message": {
            "text": "Hi!",
            "username": "ecto1",
            "bot_id": "B19LU7CSY",
            "type": "message",
            "subtype": "bot_message",
          }
        }
      )
    end

    def slack_send_message_response
      {
        "ok": true,
        "channel": "C1H9RESGL",
        "message": {
          "text": "Hi!",
          "username": "ecto1",
          "bot_id": "B19LU7CSY",
          "type": "message",
          "subtype": "bot_message",
        }
      }
    end
  end
end
