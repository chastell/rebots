module SlackApiHelpers
  def stub_slack_api_send_message_request(body)
    stub_request(:post, "https://www.slack.com/api/chat.postMessage").
      with(body:    body.to_json,
           headers: { "Accept"          => "*/*",
                      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                      "Content-Type"    => "application/x-www-form-urlencoded"
                      }
    ).to_return(status: 200, body: "", headers: {})
  end
end
