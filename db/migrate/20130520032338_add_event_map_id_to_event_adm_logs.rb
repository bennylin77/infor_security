class AddEventMapIdToEventAdmLogs < ActiveRecord::Migration
  def change
    add_column :event_adm_logs, :event_map_id, :integer
  end
end
