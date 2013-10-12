class CreatePermissionConfigsGroups < ActiveRecord::Migration
  def change
    create_table :permission_configs_groups, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :permission_config_id
      t.integer :adm_user_group_id
      t.timestamps
    end
  end
end
