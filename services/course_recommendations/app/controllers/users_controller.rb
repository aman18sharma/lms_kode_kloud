class UsersController < ApplicationController

    def next_course
        render json: {message: "Next course please"}
    end
end