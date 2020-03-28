# frozen_string_literal: true

class GrapeApi
  module Entities
    class Order < Grape::Entity
      expose :id
      expose :name
      expose :create_at
      expose :id, documentation: { type: 'integer', desc: 'Идентификатор заказа', required: true }
      expose :full_name, documentation: { type: 'string', desc: 'Полное имя заказа', required: true }
      expose :ballance, if: ->(_object, options) { options[:detail] == true }

      # expose :ballance, if: lambda { |object, options| options[:detail] == true }

      # def full_name
      #   "#{object.name} #{object.last_name}"
      # end
    end
  end
end
