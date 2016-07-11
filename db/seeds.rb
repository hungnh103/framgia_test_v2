# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |u|
  User.create! name: "Admin" + (u + 1).to_s,
    email: "admin#{u+1}@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    admin: true,
    chatwork_api_key: 123 + u,
    chatwork_id: 12 + u
end

5.times do |u|
  User.create! name: "User" + (u + 1).to_s,
    email: "user#{u+1}@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    admin: false,
    chatwork_api_key: 123 + u,
    chatwork_id: 12 + u
end

5.times do |n|
  Subject.create! name: "Subject" + (n + 1).to_s,
    chatwork_room_id: n + 1,
    number_of_question: 5,
    duration: 5
end

5.times do |n|
  Exam.create! score: 7,
    status: 1,
    time: 120,
    user_id: n + 1,
    subject_id: n + 1

end
5.times do |n|
  Question.create! content: "content" + (n + 1).to_s,
    question_type: 1,
    state: 1,
    active: true,
    subject_id: n + 1,
    user_id: n + 1
end

5.times do |n|
  Result.create! correct: true,
    question_id: n + 1,
    exam_id: n + 1
end

5.times do |n|
  Option.create! content: "content_option" + (n + 1).to_s,
    correct: true,
    question_id: n + 1
end

5.times do |n|
  Answer.create! content: "content answer" + (n + 1).to_s
end
