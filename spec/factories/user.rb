# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Ivan' }
    sequence(:last_name) { |n| "Lastame#{n}" }
    sequence(:balance, 10)
  end
end
