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

	private
	def course_params
		params.require(:course).permit(:name, :syllabus)
	end
	def set_user
		@user = current_user
	end
end

