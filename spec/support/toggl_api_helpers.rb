module TogglApiHelpers
  def stub_toggl_api_get_workspaces(response_status: 200)
    stub_request(:get, toggl_api_url).with(headers: toggl_api_headers).
      to_return(
        status: response_status,
        headers: {},
        body:  toggl_api_get_workspace_response_body.to_json
      )
  end

  def toggl_api_url
    Toggl::Api::Client::URL + Toggl::Api::WORKSPACE_USERS_PATH
  end

  def toggl_api_headers
    {
      "Accept"          => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    }
  end

  def toggl_api_get_workspace_response_body
    [
      {
        "id"                              => 1,
        "name"                            => "Workspace 1",
        "profile"                         => 0,
        "premium"                         => false,
        "admin"                           => true,
        "default_hourly_rate"             => 0,
        "default_currency"                => "USD",
        "only_admins_may_create_projects" => false,
        "only_admins_see_billable_rates"  => false,
        "only_admins_see_team_dashboard"  => false,
        "projects_billable_by_default"    => true,
        "rounding"                        => 0,
        "rounding_minutes"                => 0,
        "api_token"                       => "token",
        "at"                              => "2015-09-07T07:47:57+00:00",
        "ical_enabled"                    => true,
        "campaign"                        => false,
        "business_tester"                 => false,
        "subscription"                    => {
          "workspace_id"            => 0,
          "deleted_at"              => nil,
          "created_at"              => "0001-01-01T00:00:00Z",
          "updated_at"              => "0001-01-01T00:00:00Z",
          "vat_valid"               => false,
          "vat_validated_at"        => nil,
          "vat_invalid_accepted"    => false,
          "vat_invalid_accepted_at" => nil,
          "vat_invalid_accepted_by" => nil,
          "description"             => "Free",
          "vat_applicable"          => false
        }
      }
    ]
  end
end
