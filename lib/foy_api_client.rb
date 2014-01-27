require 'foy_api_client/version'
require 'rest-client'

module Foy
  module API
    module Client
      class Base
        def self.get_projects
          json = RestClient.get 'http://localhost:5000/v1/projects.json'
          data = JSON.parse(json)

          data.collect do |element|
            OpenStruct.new(element)
          end
        end
      end
    end
  end
end
