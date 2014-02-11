require 'spec_helper'

describe Foy::API::Client::Base do
  describe "#get_projects" do
    subject do
      Foy::API::Client::Base.new 'base'
    end
    
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
      stub_request(:get, "base/v1/projects.json").
         to_return(status: 200, body: data_json)
    end

    it "calls /v1/projects.json" do
      subject.get_projects
      WebMock.should have_requested(:get, "base/v1/projects.json")
    end

    it "returns an array" do
      result = subject.get_projects
      expect(result).to be_an(Array)
    end

    it "returns data as OpenStruct" do
      result = subject.get_projects
      expect(result.first).to be == OpenStruct.new(data)
    end
  end
end
