class AddFromToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :from, :string    
  end
end
