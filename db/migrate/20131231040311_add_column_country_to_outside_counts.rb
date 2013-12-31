class AddColumnCountryToOutsideCounts < ActiveRecord::Migration
  def change
  add_column :outside_counts , :country, :string
  end
end
