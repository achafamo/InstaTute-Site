# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

module ApplicationHelper
  def belongs_to_user?(resource)
    resource.user == current_user
  end

  def activity_resources_exist?(activity)
    activity && activity.trackable && activity.owner
  end
	def options_with_colors(colors)
		colors.collect do |color, code| 
		  "<option value='#{code}' style='background-color:#{code};'>#{color}</option> "
		end.join
	end
end
