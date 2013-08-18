class RemoveAdmUserIdFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :adm_user_id
  end
end
