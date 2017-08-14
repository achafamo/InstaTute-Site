# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class User < ActiveRecord::Base
	include Authority::UserAbilities
  rolify
  # Include default devise modules. Others available are:
  has_merit
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
    :recoverable, :rememberable, :trackable, :validatable #:omniauthable, omniauth_providers: [:google_oauth2]
  acts_as_voter
  acts_as_follower
  acts_as_followable
  acts_as_messageable

  has_many :posts
  has_many :comments
  has_many :events
  has_many :courses

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader

  validates_presence_of :name

  self.per_page = 10

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  def mailboxer_email(object)
	 #return the model's email here
	  return self.email
	end
  

	def self.search(search)
		if search != " "
			find(:all, :conditions => ['name ILIKE ?', "%#{search}%"])
		else
			find(:all)
		end
	end
	def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
   	end
	end
	def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end


end
