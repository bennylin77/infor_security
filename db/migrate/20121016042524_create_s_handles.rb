class CreateSHandles < ActiveRecord::Migration
  def change
    create_table :s_handles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.text    :handling_description
      t.timestamps
    end
  end
end
