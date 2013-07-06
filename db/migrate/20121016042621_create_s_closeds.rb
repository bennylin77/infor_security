class CreateSCloseds < ActiveRecord::Migration
  def change
    create_table :s_closeds, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.timestamps
    end
  end
end
