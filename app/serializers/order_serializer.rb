# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :networks_count, :tags
  # def name
  #  "#{object.name}"
  # end
  # def created_at
  #  "#{object.created_at}"
  # end
  def networks_count
    object.networks.count
  end
  # def tags
  #  object.tags
  # end
end
