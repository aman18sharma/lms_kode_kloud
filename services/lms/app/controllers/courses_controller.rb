class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show update destroy ]

  def index
    @courses = Course.all

    render json: @courses, status: :ok
  end

  def show
    render json: course_with_lessons_and_completion(@course), status: :ok
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: course_with_lessons_and_completion(@course), status: :created
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

    def course_with_lessons_and_completion(course)
      total_lessons = course.lessons.count
      user_id = params[:user_id] || current_user.id
      completion_percentage = 0

      if user_id.present? && total_lessons > 0
        completed_lessons_count = UserLessonCompletion.where(
          user_id: user_id,
          course_id: course.id
        ).count

        completion_percentage = (completed_lessons_count.to_f / total_lessons * 100).round
      end

      # Return the course payload with lessons and the new percentage
      course.as_json(include: :lessons).merge(
        completion_percentage: completion_percentage
      )
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.expect(course: [ :title, :description ])
    end
end
