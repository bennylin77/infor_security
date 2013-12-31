class AddMissingIndexes < ActiveRecord::Migration
  def change
	add_index :ip_maps, :adm_user_id
	add_index :ip_maps, :campus_buildings_list_id
	add_index :comments, :adm_user_id
	add_index :event_adm_logs, :adm_user_id
	add_index :event_adm_logs, :event_map_id
	add_index :jobs, :ip_map_id
	add_index :adm_users, :campus_buildings_list_id
	add_index :admin_login_logs, :adm_user_id
	add_index :job_threats, :job_id
	add_index :mail_configs, :adm_user_id
	add_index :permission_configs, :adm_user_id
	add_index :permission_configs, :adm_user_group_id
	add_index :announcemapsgroups, :announcement_id
	add_index :permission_configs_groups, :permission_config_id
	add_index :s_assigns, :job_id
	add_index :s_checks, :job_id
	add_index :s_handles, :job_id
	add_index :s_closeds, :job_id
	add_index :s_informs, :job_id
	add_index :trace_configs, :adm_user_id
  end
end