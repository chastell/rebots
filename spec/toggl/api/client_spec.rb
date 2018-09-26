require "spec_helper"

describe Toggl::Api::Client do
  describe "#get" do
    it "makes call to Toggl API and returns parsed response" do
      stub_toggl_api_get_workspaces

      response = Toggl::Api::Client.new("token").get(
        path: Toggl::Api::WORKSPACE_USERS_PATH,
      )

      expect(response).to eq(toggl_api_get_workspace_response_body)
    end
  end
end
