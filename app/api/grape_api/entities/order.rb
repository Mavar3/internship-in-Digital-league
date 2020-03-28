# frozen_string_literal: true
class GrapeApi
  module Entities
    class Order < Grape::Entity
      expose :name, documentation: { type: 'string', desc: 'Название заказа', required: true }
      expose :created_at, documentation: { type: 'string', desc: 'Время создания заказа', required: true }
      expose :networks_count, documentation: { type: 'integer', desc: 'Количество сетей у заказа', required: true }
      expose :tags, using: Entities::Tag, documentation: { type: Entities::Tag, is_array: true, desc: 'Количество тегов у заказа', required: true }

      def networks_count
        object.networks.size
      end
    end
  end
end