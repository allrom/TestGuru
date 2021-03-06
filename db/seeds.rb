# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Clears all data, then seeds tables
BadgesUser.destroy_all
TestPassage.destroy_all
Badge.delete_all
BadgeRule.delete_all
Gist.delete_all
Answer.delete_all
Question.delete_all
Test.destroy_all
Category.delete_all
User.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

users = Admin.create([
  {
    identity_name: "Big",
    identity_sname: "Guru",
    email: "allrom67@gmail.com",
    password: 'super'
    }
])

categories = Category.create([
  { title: "FrontEnd" },
  { title: "BackEnd" },
  { title: "BigData" }
])

tests = Test.create([
  { title: "Ruby Language", level: 5, category_id: categories[1].id, author_id: User.first.id },
  { title: "PHP Language", level: 3, category_id: categories[1].id, author_id: User.first.id },
  { title: "HTML", level: 1, category_id: categories[0].id, author_id: User.first.id },
  { title: "JavaScript", level: 3, category_id: categories[0].id, author_id: User.first.id },
  { title: "BigData Platforms", level: 1, category_id: categories[2].id, author_id: User.first.id }
])

questions = Question.create([
  { body: "What are different Ruby editors?", test_id: tests[0].id },
  { body: "What are different variables in Ruby?", test_id: tests[0].id },
  { body: "Who is Ruby Inventor?", test_id: tests[0].id },
  { body: "What does a \"Class\" means?", test_id: tests[0].id },
  { body: "Arguments pass to methods by appending brackets to its name", test_id: tests[0].id },
  { body: "What is \"initialize\" method?", test_id: tests[0].id },
  { body: "What are Ruby data types?", test_id: tests[0].id },
  { body: "How is it possible to parse a configuration file?", test_id: tests[1].id },
  { body: "What is PHP?", test_id: tests[1].id },
  { body: "What are heading tags and how do you use them?", test_id: tests[2].id },
  { body: "What is JavaScript file extension?", test_id: tests[3].id },
  { body: "What is Big Data?", test_id: tests[4].id }
])

answers = Answer.create([
  { body: "Atom, Sublime", correct: true, question_id: questions[0].id },
  { body: "NotePad", question_id: questions[0].id },
  { body: "Local, global, class, instance", correct: true, question_id: questions[1].id },
  { body: "Matz", correct: true, question_id: questions[2].id },
  { body: "Ruby Rode", question_id: questions[2].id },
  { body: "A class is the blueprint from which  objects are created", correct: true, question_id: questions[3].id },
  { body: "No, by appending parentheses", correct: true, question_id: questions[4].id },
  { body: "It's a special Ruby method", correct: true, question_id: questions[5].id },
  { body: "Numbers", correct: true, question_id: questions[6].id },
  { body: "Scripts", question_id: questions[6].id },
  { body: "Hashes", correct: true, question_id: questions[6].id },
  { body: "Win word", question_id: questions[7].id },
  { body: "Open source scripting language", correct: true, question_id: questions[8].id },
  { body: "Avoid using heading markup tags", question_id: questions[9].id },
  { body: "\*.jvs", question_id: questions[10].id },
  { body: "Large and complex datasets", correct: true, question_id: questions[11].id }
])

badge_rules = BadgeRule.create([
  { body: "TestGuru Participant (Exam Passed)", code: "start", value: "general", awarded_once: false, },
  { body: "TestGuru All Simple Level", code: "level", value: "simple"},
  { body: "TestGuru OneShot Fast Pass", code: "fast_start", value: "general", awarded_once: false,},
  { body: "TestGuru All Moderate Level", code: "level", value: "moderate"},
  { body: "TestGuru All BackEnd Professional", code: "category", value: "backend"}
])

badges = Badge.create([
  { title: "Passed the Test", image_filename: "Cert_prt.png", rule_id: badge_rules[0].id },
  { title: "Basic Associate", image_filename: "Cert_simple.png", rule_id: badge_rules[1].id},
  { title: "Test pass-at-once", image_filename: "Cert_shot.png", rule_id: badge_rules[2].id },
  { title: "BackEnd Professional", image_filename: "Cert_bkend.png", rule_id: badge_rules[4].id }
])
