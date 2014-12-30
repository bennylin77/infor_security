class AddColumnReceiveFrom < ActiveRecord::Migration
  def change
  	add_column :fireeye_logs, :receive_from, :string
  end
end
