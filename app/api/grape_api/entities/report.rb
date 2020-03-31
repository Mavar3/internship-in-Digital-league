class GrapeApi
  module Entities
    class Report < Grape::Entity
      # expose :get_link, if: lambda { |object, options|  options[:link] != nil } 

      # def get_link
      #   "http://localhost:3000/api/reports/#{link}"
      # end
    end
  end
end