class AddDateToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :start_show, :datetime
	add_column :announcements, :end_show, :datetime
  end
end
