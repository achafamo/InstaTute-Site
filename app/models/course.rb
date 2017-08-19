class Course < ApplicationRecord
	belongs_to :user
	has_attached_file :syllabus

	validates_attachment_content_type :syllabus, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
	validates_presence_of :syllabus
end
