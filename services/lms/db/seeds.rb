# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
user1 = User.create(full_name: "Aman Sharma 1", age: 30, email: 'aman1@example.com', password: '12345678')
user2 = User.create(full_name: "Aman Sharma 2", age: 30, email: 'aman2@example.com', password: '12345678')
user3= User.create(full_name: "Aman Sharma 3", age: 30, email: 'aman3@example.com', password: '12345678')
user4 = User.create(full_name: "Aman Sharma 4", age: 30, email: 'aman4@example.com', password: '12345678')
user5 = User.create(full_name: "Aman Sharma 5", age: 30, email: 'aman5@example.com', password: '12345678')
user6 = User.create(full_name: "Aman Sharma 6", age: 30, email: 'aman6@example.com', password: '12345678')
user7 = User.create(full_name: "Aman Sharma 7", age: 30, email: 'aman7@example.com', password: '12345678')

[user1, user2, user3, user4, user5, user6, user7].each do |user|
    10.times do |i|
        course = Course.create(title: "Course #{i + 1}", description: "This is description #{i+1}")
        user_course = UserCourse.create(user_id: user.id, course_id: course.id)
        20.times do |i|
            course.lessons.create(lesson_name: "Lesson Name #{i+1}", lesson_description: "Lesson Description #{i+1}")
        end
    end
end


