require 'foy_api_client/version'
require 'rest-client'

module Foy
  module API
    module Client
      class Base
        def self.get_projects
          json = RestClient.get 'http://localhost:5000/v1/projects.json', {:accept => :json}
          data = JSON.parse(json)

          data.collect do |element|
            OpenStruct.new(element)
          end
        end

        def self.put_project_packages(project_id: nil, packages: [], system: nil)
          RestClient.put "http://localhost:5000/v1/projects/#{project_id}/packages.json", {packages: packages}.to_json, {params: {system: system}, accept: :json, content_type: :json}
        end
      end
    end
  end
end
