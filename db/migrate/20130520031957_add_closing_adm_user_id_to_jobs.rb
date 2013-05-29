class AddClosingAdmUserIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :closing_adm_user_id, :integer
  end
end
