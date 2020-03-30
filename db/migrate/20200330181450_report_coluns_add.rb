class ReportColunsAdd < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :max_count_ram, :text 
    add_column :reports, :max_additional_hdd, :text
    add_column :reports, :max_additional_memory_hdd, :text
  end
end
