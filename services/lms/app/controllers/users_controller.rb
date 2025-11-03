class UsersController < ApplicationController
    before_action :set_user, only: %i[user_courses stats show]

    def index
        users = User.all
        render json: users, status: :ok
    end

    def show
        render json: @user, status: :ok
    end

    def user_courses
        courses = @user.courses
        render json: courses, status: :ok
    end
    
    def stats
        lesson_completions = @user.user_lesson_completions
        completed_lessons = lesson_completions.count

        completed_courses = 0

        if completed_lessons > 0
            total_lessons_per_course = Lesson.where(course_id: lesson_completions.pluck(:course_id).uniq)
                                            .group(:course_id).count

            completed_lessons_per_course = lesson_completions.group(:course_id).count

            total_lessons_per_course.each do |course_id, total|
                if completed_lessons_per_course[course_id] == total && total > 0
                    completed_courses += 1
                end
            end
        end
        last_completed_at = lesson_completions.maximum(:completed_at)

        render json: {
            lessons_completed: completed_lessons,
            courses_completed: completed_courses,
            last_completed_at: last_completed_at
        }, status: :ok
    end

    private

    def set_user
        begin  
            @user = User.find(params.expect(:id))
        rescue ActiveRecord::RecordNotFound => error
            render json: {message: "Record Not Found"}, status: :not_found
        end
    end
end