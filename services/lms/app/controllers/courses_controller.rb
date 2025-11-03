class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show update destroy ]

  def index
    @courses = Course.all

    render json: @courses, status: :ok
  end

  def show
    render json: @course, status: :ok
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_content
    end
  end

  def update
    if @course.update(course_params)
      render json: @course, status: :ok
    else
      render json: @course.errors, status: :unprocessable_content
    end
  end

  def destroy
    @course.destroy!
    render json: {"message": "Record deleted successfully!"}, status: :ok
  end

  private
    def set_course
      begin  
        @course = Course.find(params.expect(:id))
      rescue ActiveRecord::RecordNotFound => error
        render json: {message: "Record Not Found"}, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.expect(course: [ :title, :description ])
    end
end
