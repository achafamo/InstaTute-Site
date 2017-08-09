class EditEventCourseName < ActiveRecord::Migration[5.0]
  def self.up
		add_column :events, :course_name
	end
  def change
		change_column :events, :course_name, :string
  end
end
