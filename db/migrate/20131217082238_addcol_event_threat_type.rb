class AddcolEventThreatType < ActiveRecord::Migration
  def change
    add_column :event_maps , :threat_type , :string
  end
end
