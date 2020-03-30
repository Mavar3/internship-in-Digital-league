# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders
  has_one :passport_data
  has_one :report
end
