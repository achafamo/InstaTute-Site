class ChangeTheModelAtTime1500500835 < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :user_id, :string
  end
end
