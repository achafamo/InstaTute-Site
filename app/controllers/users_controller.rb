# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :check_ownership, only: [:edit, :update]
  respond_to :html, :js

  def show
    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
	def index
  	@users = User.all
  	if params[:search]
    	@users = User.search(params[:search]).order("created_at DESC")
  	else
    	@users = USer.all.order("created_at DESC")
  	end
		render 'index'
	end

  def edit
		@roles =  Role.all #[:student, :professor, :admin]
  end

  def update
		params[:user][:role_ids] ||= []
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def deactivate
  end

  def friends
    @friends = @user.following_users.paginate(page: params[:page])
  end

  def followers
    @followers = @user.user_followers.paginate(page: params[:page])
  end

  def mentionable
    render json: @user.following_users.as_json(only: [:id, :name]), root: false
  end
	def calendar
    if request.xhr?
      friend_events = Event.select("events.*").joins("INNER JOIN follows ON events.user_id = follows.followable_id").where("follows.follower_id = #{current_user.id} AND follows.followable_type ='User'")
      current_user_events = current_user.events
      @events = Event.from("(#{friend_events.to_sql} UNION #{current_user_events.to_sql}) as events").where("events.start_datetime BETWEEN '#{params[:start]}' AND '#{params[:end]}'")
    end
    respond_to do |format|
      format.html
      format.json { render :json => @events, each_serializer: EventCalendarSerializer }
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :about, :avatar, :cover,
                                 :sex, :dob, :location, :phone_number, role_ids: [])
  end

  def check_ownership
    redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
  end

  def set_user
    @user = User.friendly.find_by(slug: params[:id]) || User.find_by(id: params[:id])
    render_404 and return unless @user
  end
end
