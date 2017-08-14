# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class Event < ActiveRecord::Base
  resourcify
  include Authority::Abilities  
  include Shared::Callbacks
	
  belongs_to :user
	has_many :course
  acts_as_votable
  acts_as_commentable

  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  validates_presence_of :name
  validates_presence_of :start_datetime
	
  validates_presence_of :user
end
