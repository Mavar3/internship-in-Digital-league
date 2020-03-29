class GrapeApi
  module Entities
    class Report < Grape::Entity
      expose :cost, documentation: { type: 'integer', desc: 'Стоимость заказа', required: true }
    end
  end
end