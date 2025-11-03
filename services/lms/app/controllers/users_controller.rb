class UsersController < ApplicationController
    before_action :set_user, only: %i[user_courses]

    def index
        users = User.all
        render json: users, status: :ok
    end

    def user_courses
        courses = @user.courses
        render json: courses, status: :ok
    end

    private

    def set_user
        begin  
            @user = User.find(params.expect(:user_id))
        rescue ActiveRecord::RecordNotFound => error
            render json: {message: "Record Not Found"}, status: :not_found
        end
    end
end