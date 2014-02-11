require 'spec_helper'

describe Foy::API::Client::Base do
  describe ".get_packages" do
    subject do
      Foy::API::Client::Base.new 'base'
    end

    let(:data) do
      {
        name: "rspec",
        version: "1.0.2"
      }
    end

    let(:data_json) do
      [data].to_json
    end

    let(:system) do
      'pip'
    end

    before do
      stub_request(:get, "base/v1/packages/#{system}.json").
         to_return(status: 200, body: data_json)
    end

    it "calls /v1/projects.json" do
      subject.get_packages(system: system)
      WebMock.should have_requested(:get, "base/v1/packages/#{system}.json")
    end

    it "returns an array" do
      result = subject.get_packages(system: system)
      expect(result).to be_an(Array)
    end

    it "returns data as OpenStruct" do
      result = subject.get_packages(system: system)
      expect(result.first).to be == OpenStruct.new(data)
    end
  end
end

