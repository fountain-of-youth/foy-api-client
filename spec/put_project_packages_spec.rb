require 'spec_helper'

describe Foy::API::Client::Base do
  describe "#put_project_packages" do
    subject do
      Foy::API::Client::Base.new 'base'
    end

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
      stub_request(:put, /.*/).
        to_return(status: 200)
    end

    it "calls put /v1/projects/:id/packages.json?system=rubygems" do
      subject.put_project_packages(project_id: project_id, packages: data, system: 'rubygems')
      WebMock.should have_requested(:put, "base/v1/projects/321/packages.json").with(query: {system: "rubygems"})
    end

    it "sends data as json" do
      subject.put_project_packages(project_id: project_id, packages: data, system: 'rubygems')
      WebMock.should have_requested(:put, /.*/).
        with(body: {packages: data}.to_json)
    end

    it "indicates content as json" do
      subject.put_project_packages(project_id: project_id, packages: data, system: 'rubygems')
      WebMock.should have_requested(:put, /.*/).
        with(headers: {"Content-Type" => 'application/json'})
    end
  end
end

