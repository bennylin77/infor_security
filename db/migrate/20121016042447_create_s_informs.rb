class CreateSInforms < ActiveRecord::Migration
  def change
    create_table :s_informs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.text  :description_alternation
      t.text  :name_alternation
      t.text  :suggestion_alternation
      t.string  :log_level
      t.datetime :informed_at
      t.timestamps
    end
  end
end
