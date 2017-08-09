class EditEventCourseName < ActiveRecord::Migration[5.0]
  def change
		change_column :events, :course_name, :string
  end
end
