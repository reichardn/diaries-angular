# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email:'fake@fake.com', password:'12345678', password_confirmation:'12345678')

diary = user.diaries.create

user.current_diary = diary

project = Project.create(name: 'blockbuster')

diary.entries.create(project: project, minutes: 60, day: :monday)

# user = User.create(email:'admin@admin.com', password:'12345678', password_confirmation:'12345678')