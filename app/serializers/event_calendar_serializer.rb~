class EventCalendarSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :title, :allDay

  def title
    object.name
  end
	def course
		object.course_title
	end
  def start
    object.start_datetime
  end

  def end
    object.end_datetime
  end

  def allDay
    object.all_day
  end
	def description
		object.description
	end

end
