require 'foy_api_client/version'
require 'rest-client'

module Foy
  module API
    module Client
      class Base
        def self.get_projects
          json_data = RestClient.get 'http://localhost:5000/v1/projects.json', {:accept => :json}
          parse_collection(json_data)
        end

        def self.put_project_packages(project_id: nil, packages: [], system: nil)
          RestClient.put "http://localhost:5000/v1/projects/#{project_id}/packages.json", {packages: packages}.to_json, {params: {system: system}, accept: :json, content_type: :json}
        end

        def self.get_packages(system: system)
          json_data = RestClient.get "http://localhost:5000/v1/packages/#{system}.json", {:accept => :json}
          parse_collection(json_data)
        end

        private

        def self.parse_collection(json_data)
          data = JSON.parse(json_data)

          data.collect do |element|
            OpenStruct.new(element)
          end
        end
      end
    end
  end
end
