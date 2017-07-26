class RenameEventsWhenColumn < ActiveRecord::Migration[5.0]
  def self.down
    remove_column :events, :start
  end
  def change
    rename_column :events, :event_datetime, :start
  end
end
