module SlackApiHelpers
  def stub_slack_api_get_users_request(status:200)
    stub_request(:get, get_users_url).with(headers: slack_api_headers).
      to_return(status: status, headers: {}, body: slack_api_get_users_response_body.to_json)
  end

  def stub_slack_api_send_message_request(status:200)
    stub_request(:post, send_message_url).with(headers: slack_api_headers).
      to_return(status: status, headers: {}, body: slack_api_send_message_response_body.to_json)
  end

  def slack_api_headers
    {
      "Accept"          => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Type"    => "application/x-www-form-urlencoded",
      "User-Agent"      => "Faraday v0.9.1"
    }
  end

  def slack_api_send_message_response_body
    {
      "ok"       => true,
      "message"  => {
          "text" => "Here's a message for you",
          "attachments" => [
              {
                  "text" => "This is an attachment"
              }
          ],
          "type"    => "message",
          "subtype" => "bot_message",
      }
    }
  end

  def slack_api_get_users_response_body
    {
      "ok"      => true,
      "members" => [
          {
              "id"       => "W012A3CDE",
              "team_id"  => "T012AB3C4",
              "name"     => "spengler",
              "deleted"  => false,
              "tz"       => "America/Los_Angeles",
              "tz_label" => "Pacific Daylight Time",
              "profile" => {
                  "avatar_hash"  => "ge3b51ca72de",
                  "status_text"  => "Print is dead",
                  "status_emoji" => ":books:",
                  "real_name"    => "Egon Spengler",
                  "display_name" => "spengler",
                  "email"        => "spengler@ghostbusters.example.com",
              },
              "is_admin"         => true,
              "is_owner"         => false,
              "is_primary_owner" => false,
              "is_restricted"    => false,
              "is_bot"           => false,
          },
          {
            "id"        => "W07QCRPA4",
            "team_id"   => "T0G9PQBBK",
            "name"      => "glinda",
            "deleted"   => false,
            "color"     => "9f69e7",
            "real_name" => "Glinda Southgood",
            "tz"        => "America/Los_Angeles",
            "tz_label"  => "Pacific Daylight Time",
            "profile" => {
                "real_name"            => "Glinda Southgood",
                "real_name_normalized" => "Glinda Southgood",
                "display_name"         => "Glinda the Fairly Good",
                "email"                => "glenda@south.oz.coven"
            },
            "is_admin"         => true,
            "is_owner"         => false,
            "is_primary_owner" => false,
            "is_restricted"    => false,
            "is_bot"           => false,
          }
      ]
  }
  end

  def get_users_url
    Slack::Api::Client::URL + "/" + Slack::Api::GET_USERS_PATH
  end

  def send_message_url
    Slack::Api::Client::URL + "/" + Slack::Api::POST_MESSAGE_PATH
  end
end
