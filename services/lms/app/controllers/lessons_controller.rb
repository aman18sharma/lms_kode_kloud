class LessonsController < ApplicationController
  before_action :set_course, except: %i[ mark_complete ]
  before_action :set_lesson, only: %i[ show update destroy ]

  def index
    @lessons = @course.lessons

    render json: @lessons, status: :ok
  end

  def show
    render json: @lesson, status: :ok
  end

  def create
    @lesson = @course.lessons.new(lesson_params)

    if @lesson.save
      render json: @lesson, status: :created
    else
      render json: @lesson.errors, status: :unprocessable_content
    end
  end

  def update
    if @lesson.update(lesson_params)
      render json: @lesson, status: :ok
    else
      render json: @lesson.errors, status: :unprocessable_content
    end
  end

  def destroy
    @lesson.destroy!
    render json: {"message": "Record deleted successfully!"}, status: :ok
  end

  def mark_complete
    lesson = Lesson.find_by_id(params.expect(:id))
    render json: {message: "Lesson Not Found"}, status: :not_found and return if lesson.nil?
    user_lesson_completion = current_user
                              .user_lesson_completions.new(course_id: lesson.course_id,
                                                           lesson_id: lesson.id,
                                                           completed_at: Time.now, 
                                                           is_completed: true)
    if user_lesson_completion.save
      render json: { message: "Lesson completed successfully!", lesson: lesson }, status: :ok
    else
      render json: @lesson.errors, status: :unprocessable_contentsssss 
    end
  end

  private
    def set_lesson
      begin
        @lesson = @course.lessons.find(params.expect(:id))
      rescue ActiveRecord::RecordNotFound => error
        render json: {message: "Lesson Not Found"}, status: :not_found
      end
    end

    def set_course
      begin  
        @course = Course.find(params.expect(:course_id))
      rescue ActiveRecord::RecordNotFound => error
        render json: {message: "Course Not Found"}, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.expect(lesson: [ :lesson_name, :lesson_description, :course_id ])
    end
end
