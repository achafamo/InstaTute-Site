class AddCourseTItleToEvents < ActiveRecord::Migration[5.0]
  def self.up
	add_column :events, :course_title, :string
  end
end
