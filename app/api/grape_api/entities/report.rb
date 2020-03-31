class GrapeApi
  module Entities
    class Report < Grape::Entity
      expose :U_can_check_Ur_result_at do |object, options|
        "http://localhost:3000/api/reports/#{options[:link]}"
      end
    end
  end
end