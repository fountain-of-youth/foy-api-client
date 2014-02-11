require 'foy_api_client/version'
require 'rest-client'

module Foy
  module API
    module Client
      class Base
        def initialize(base_url)
          @base_url = base_url
        end

        def get_projects
          json_data = RestClient.get "#{@base_url}/v1/projects.json", {:accept => :json}
          parse_collection(json_data)
        end

        def put_project_packages(project_id: nil, packages: [], system: nil)
          RestClient.put "#{@base_url}/v1/projects/#{project_id}/packages.json", {packages: packages}.to_json, {params: {system: system}, accept: :json, content_type: :json}
        end

        def get_packages(system: system)
          json_data = RestClient.get "#{@base_url}/v1/packages/#{system}.json", {:accept => :json}
          parse_collection(json_data)
        end

        def put_packages(system: system, packages: [])
          RestClient.put "#{@base_url}/v1/packages/#{system}.json", {packages: packages}.to_json, {accept: :json, content_type: :json}
        end

        private

        def parse_collection(json_data)
          data = JSON.parse(json_data)

          data.collect do |element|
            OpenStruct.new(element)
          end
        end
      end
    end
  end
end
