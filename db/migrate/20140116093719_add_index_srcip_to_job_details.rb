class AddIndexSrcipToJobDetails < ActiveRecord::Migration
  def change
  add_index :job_details, :src_ip
  end
end
