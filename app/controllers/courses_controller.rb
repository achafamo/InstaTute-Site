class CoursesController < ApplicationController
	before_action :set_user
  before_action :authenticate_user!
	def index
    if params[:search]
      @courses = Course.search(params[:search]).order("created_at DESC")
    else
    	@courses = @current_user.courses #Course.order('created_at DESC').paginate(page: params[:page], per_page: 30)
		end 	
	end
	def show
    #@comments = @post.comments.all
		@course = Course.find(params[:id])

  end

	def new
		@course = Course.new
	end
  def create
    @course = @current_user.courses.new(course_params)
    if @course.save
      redirect_to courses_path
    else
      redirect_to root_path, notice: @post.errors.full_messages.first
    end
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
	def course_params
		params.require(:course).permit(:name, :syllabus)
	end
	def set_user
		@user = current_user
	end
end

