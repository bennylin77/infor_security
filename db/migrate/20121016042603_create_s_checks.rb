class CreateSChecks < ActiveRecord::Migration
  def change
    create_table :s_checks, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.timestamps
    end
  end
end
