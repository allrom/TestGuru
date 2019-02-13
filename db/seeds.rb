# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Clears all data, then seeds tables
Answer.delete_all
Question.delete_all
Test.destroy_all
Category.delete_all
User.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

users = User.create([
  { identity: "Administrator", email: "adm@testguru.edu" },
  { identity: "Ivan Reeds", email: "ivan.reeds@testguru.edu" },
  { identity: "Dave Choker", email: "dave.choker@testguru.edu" }
])

categories = Category.create([
  { title: "FrontEnd" },
  { title: "BackEnd" },
  { title: "BigData" }
])

tests = Test.create([
  { title: "Ruby Language", level: 5, category_id: categories[1].id, author_id: User.first.id },
  { title: "PHP Language", level: 3, category_id: categories[1].id, author_id: User.first.id },
  { title: "HTML", level: 2, category_id: categories[0].id, author_id: User.first.id },
  { title: "JavaScript", level: 3, category_id: categories[0].id, author_id: User.first.id },
  { title: "BigData Platforms", level: 1, category_id: categories[2].id, author_id: User.first.id }
])

questions = Question.create([
  { body: "What are different Ruby editors?", test_id: tests[0].id },
  { body: "What are different variables in Ruby?", test_id: tests[0].id },
  { body: "How is it possible to parse a configuration file?", test_id: tests[1].id },
  { body: "What is PHP?", test_id: tests[1].id },
  { body: "What are attributes and how do you use them?", test_id: tests[2].id },
  { body: "What is Big Data?", test_id: tests[4].id }
])

answers = Answer.create([
  { body: "Atom, Sublime", correct: true, question_id: questions[0].id },
  { body: "Local, global, class, instance", correct: true, question_id: questions[0].id },
  { body: "Win word", question_id: questions[0].id },
  { body: "Open source scripting language", correct: true, question_id: questions[0].id },
  { body: "Large and complex datasets", correct: true, question_id: questions[5].id }
])

# populates the users <-> tests join table
User.all.find_each do |user|
  2.times do
    user.tests << tests.sample
  end
end
