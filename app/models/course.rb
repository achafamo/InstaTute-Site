class Course < ApplicationRecord
	belongs_to :user
	has_attached_file :syllabus, styles: { small: "64x64", med: "100x100", large: "200x200" }

	validates_attachment_content_type :syllabus, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
end
