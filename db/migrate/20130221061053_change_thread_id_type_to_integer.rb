class ChangeThreadIdTypeToInteger < ActiveRecord::Migration

  def change
    change_column :event_maps, :thread_id, :integer
  end
  
end
