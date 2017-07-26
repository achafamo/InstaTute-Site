class AddColumnTumnToEvents < ActiveRecord::Migration[5.0]
  def self.up
    add_column :events, :all_day, :boolean
  end
end
