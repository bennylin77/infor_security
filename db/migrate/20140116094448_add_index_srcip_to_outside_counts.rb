class AddIndexSrcipToOutsideCounts < ActiveRecord::Migration
  def change
   add_index :outside_counts, :src_ip
  end
end
