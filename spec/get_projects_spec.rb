require 'spec_helper'

describe Foy::API::Client::Base do
  describe ".get_projects" do
    let(:data) do
      {
        id: "2",
        repository: "New Repo",
        title: "New Project"
      }
    end

    let(:data_json) do
      [data].to_json
    end

    before do
      stub_request(:get, "http://localhost:5000/v1/projects.json").
         to_return(status: 200, body: data_json)
    end

    it "calls /v1/projects.json" do
      Foy::API::Client::Base.get_projects
      WebMock.should have_requested(:get, "http://localhost:5000/v1/projects.json")
    end

    it "returns an array" do
      result = Foy::API::Client::Base.get_projects
      expect(result).to be_an(Array)
    end

    it "returns data as OpenStruct" do
      result = Foy::API::Client::Base.get_projects
      expect(result.first).to be == OpenStruct.new(data)
    end
  end
end
