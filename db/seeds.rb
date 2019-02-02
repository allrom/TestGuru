# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Clears all data, then seeds
Answer.delete_all
Question.delete_all
Test.delete_all
Category.delete_all
User.delete_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

users = [
  { identity: "Ivan Dyakovich" },
  { identity: "Dave Choker" },
  { identity: "Brian Lomm" },
  { identity: "Chris Malt" }
]

categories = [
  { title: "FrontEnd" },
  { title: "BackEnd" },
  { title: "BigData" }
]

tests = [
  { title: "Ruby Language", level: 3, category_id: 2 },
  { title: "PHP Language", level: 3, category_id: 2 },
  { title: "HTML", level: 2, category_id: 1 },
  { title: "JavaScript", level: 3, category_id: 1 },
  { title: "BigData Platforms", level: 1, category_id: 3 }
]

questions = [
  { body: "What are different Ruby editors?", test_id: 1 },
  { body: "What are different variables in Ruby?", test_id: 1 },
  { body: "How is it possible to parse a configuration file?", test_id: 4 },
  { body: "What is PHP?", test_id: 2 },
  { body: "What are attributes and how do you use them?", test_id: 3 },
  { body: "What is Big Data?", test_id: 5 }
]

answers = [
  { body: "Atom, Sublime", correct: true, question_id: 1, user_id: 1 },
  { body: "local, global, class, instance", correct: true, question_id: 2, user_id: 3 },
  { body: "win word", question_id: 3, user_id: 2 },
  { body: "open source scripting language", correct: true, question_id: 4, user_id: 1 }
]

users.each do |user|
  User.create user
end

categories.each do |category|
  Category.create category
end

tests.each do |test|
  Test.create test
end

questions.each do |question|
  Question.create question
end

answers.each do |answer|
  Answer.create answer
end
