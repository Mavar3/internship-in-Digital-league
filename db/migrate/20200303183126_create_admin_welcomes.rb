class CreateAdminWelcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_welcomes do |t|

      t.timestamps
    end
  end
end
