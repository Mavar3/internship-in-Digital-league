# frozen_string_literal: true

class CreateAdminWelcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_welcomes, &:timestamps
  end
end
