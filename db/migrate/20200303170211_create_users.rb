class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :name
      t.integer :balance

      t.timestamps
    end
  end
end
