class CreateJoinTableOrdersNetwork < ActiveRecord::Migration[6.0]
  def change
    create_join_table :orders, :Networks do |t|
      # t.index [:order_id, :network_id]
      # t.index [:network_id, :order_id]
    end
  end
end
