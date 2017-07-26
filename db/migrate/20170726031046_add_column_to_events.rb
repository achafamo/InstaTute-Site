class AddColumnToEvents < ActiveRecord::Migration[5.0]
  def self.up
    add_column :events, :end_datetime, :datetime
  end
end
