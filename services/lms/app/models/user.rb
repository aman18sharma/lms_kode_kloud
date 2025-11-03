class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
                 jwt_revocation_strategy: JwtDenylist
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_lesson_completions, dependent: :destroy
end
