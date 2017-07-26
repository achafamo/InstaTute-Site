class AddCourseToEvents < ActiveRecord::Migration[5.0]
  def self.up
	add_column :events, :course_name, :course
  end
end
