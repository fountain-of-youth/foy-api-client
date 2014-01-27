require 'spec_helper'

describe Foy::API::Client::Base do
  describe ".put_project_packages" do
    let(:project_id) do
      "321"
    end

    let(:data) do
      [
        {name: 'rest-client', version: '1.0.1'},
        {name: 'rspec', version: '2.0.0'}
      ]
    end

    let(:data_json) do
      data.to_json
    end

    before do
      stub_request(:put, "http://localhost:5000/v1/projects/321/packages.json").
        to_return(status: 200)
    end

    it "calls put /v1/projects/:id/packages.json" do
      Foy::API::Client::Base.put_project_packages(project_id, data)
      WebMock.should have_requested(:put, "http://localhost:5000/v1/projects/321/packages.json")
    end

    it "sends data as json" do
      Foy::API::Client::Base.put_project_packages(project_id, data)
      WebMock.should have_requested(:put, /.*/).
        with(body: data_json)
    end
  end
end

