class AddclassToEvents < ActiveRecord::Migration[5.0]
  def self.down
		remove_column :events, :course_name
	end
  def self.up
		add_column :events, :course, :string
  end
end
