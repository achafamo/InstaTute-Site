class AddPaperclipToPost < ActiveRecord::Migration[5.0]
	add_attachment :posts, :image
  def change
  end
end
