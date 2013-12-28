class AddColumnSrcIpToOustideCounts < ActiveRecord::Migration
  def change
    add_column :outside_counts , :src_ip , :string
  end
end
