class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
		rename_column :events, :event_datetime, :start_datetime
  end
	
end
