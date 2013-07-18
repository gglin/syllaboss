# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require "#{Rails.root}/lib/library_parser.rb"

data_folder = File.expand_path('../data', __FILE__)

SchoolDay.delete_all
Potd.delete_all
Link.delete_all
SchoolDayLink.delete_all
Todo.delete_all
SchoolDayTodo.delete_all


potd1 = Potd.new
potd1.name = "Alan Kay"
potd1.wikipedia = "http://en.wikipedia.org/wiki/Alan_Kay"
potd1.presentation_url = "www.sesamestreet.com"
potd1.save
puts "Saved potd1"

potd2 = Potd.new
potd2.name = "John McCarthy"
potd2.wikipedia = "http://en.wikipedia.org/wiki/John_McCarthy_(computer_scientist)"
potd2.presentation_url = "www.yahoo.com"
potd2.save
puts "Saved potd2"

potd3 = Potd.new
potd3.name = "Cookie Monster"
potd3.wikipedia = "http://en.wikipedia.org/wiki/Cookie_Monster"
potd3.presentation_url = "www.whatbadgerseat.com"
potd3.save
puts "Saved potd3"


day5 = potd1.school_days.build(:ordinal=>5, :week=>1)
day5.calendar_date = (DateTime.now+1).to_date
day5.schedule = 
"9:00 - 10: Ruby & SQL Homework Review
10 - 12: Final Work on Layouts (Go grab your lunch, we're eating in the school)
12 - 1: Lunch / Origami
1 - 2: Layout Discussion
2 - 4: Ruby Lecture - 2 and POTD
4 - 6: Feeling Friday and FAF "
day5.save
puts "Saved day5"

day6 = potd2.school_days.build(:ordinal=>6, :week=>2)
day6.calendar_date = (DateTime.now+2).to_date
day6.schedule = 
"9:00 - 9:15: Blogs

9:15 - 9:45: Homework Review

9:45 - 11:30: Ruby Lecture 3

11:30 - 12:30: CLI Jukebox (https://gist.github.com/aviflombaum/eb3e360d4c59d02edf8c) - Group Work

12:30 - 1:30: Lunch

1:30 - 2:30: CLI Jukebox - Group Work

2:30 - 3: CLI Jukebox Review

3 - 3:15 - POTD John McCarthy

3:15 - 5: Ruby Lecture 4 (everything up to OO)

5 - 6: Student Profile Merge Take #2
#day6 #plan"
day6.save
puts "Saved day6"

day7 = potd1.school_days.build(:ordinal=>7, :week=>11)
day7.calendar_date = (DateTime.now+3).to_date
day7.schedule = 
"9:00 - 9:15: Blog Reviews
9:15 - 11:40: HW Review, POTD
11:40 - 12:40: Lunch

1 - 3: Group Work / Student Layout Merge

While Blake and I confirm that all group work is in the repo, you should be working on:

Decoder 
Green Grocer 
Pokemon

Whenever the layouts are done, we'll stop and discuss them. Whatever you don't finish will be homework (in terms of the Ruby Work)

3 - 4: Guest Speaker

4 - 6: Student Layout / Group Work - The student Layouts must be standardized by tomorrow morning!
#plan #day7"
day7.save
puts "Saved day7!"


link1 = Link.new(:title => "Ruby docs")
link1.link_url = "www.rubydocs.org"
link1.description = "read this"
link1.save
puts "Saved link1"

link2 = Link.new(:title => "Sharknado")
link2.link_url = "www.sharknado.org"
link2.description = "watch this"
link2.save
puts "Saved link2"

day2 = SchoolDay.new(:ordinal => 11, :week => 18)
day2.schedule = "9:00 - 9:15: POTD - The Shell

9:15 - 9:30: Review Yesterday, Today's Plan

9:30 - 10: Basic Git Workflow

10 - 11: HTML Questions Review (Grover)

11 - 12:30: Work on Profiles - Your goal is to have a team branch that contains all your individual profiles on the main flatiron-school repository.

12:30 - 1:30: Lunch

1:30 - 3:30: Environment Setup

4:00 - 5:30: Work on Profiles - FINISH THEM - Get a version 1 done. No matter what.

5:30 - 6:30: Merge profiles into master and review them

#plan #day2 "
day2.calendar_date = (DateTime.now+4).to_date 
day2.links.build(:link_url=>"ruby-doc.org", :title => "Ruby Docs", :description => "docs for ruby")
day2.save
puts "Saved day2!"

day2.todos.build(:name => "TODO5", :gist => "gist@github.com/code-warmup")
day2.save
puts "Saved day2 again with TODO!"

# day11 = SchoolDay.create(:ordinal => 11)
# day11.links.build(:title => "ruby docs")




# reading1 = day5.readings.build(:creator => 1)
# reading2 = day5.readings.build(:creator => 1)
# reading3 = day5.readings.build(:creator => 1)




# reading1.title = "Weekend Reading #1: Zetcode SQLite Tutorial"
# reading1.content = "Read this http://zetcode.com/db/sqlite/ - it's great (adding it to prework).

# #sql #reading"


# reading2.title = "Weekend Reading#2: CodeAcademy Ruby Modules"
# reading2.content = "Do these:

# http://www.codecademy.com/courses/ruby-beginner-en-d1Ylq?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-MxXx5/0/1?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-NFCZ7?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-JdNDe/0/1?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-XYcN1?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-mzrZ6/0/1?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-F3loB?curriculum_id=5059f8619189a5000201fbcb
# http://www.codecademy.com/courses/ruby-beginner-en-693PD/0/1?curriculum_id=5059f8619189a5000201fbcb

# #reading #ruby "


# reading3.title = "Weekend  #3: Ruby Logic"
# reading3.content = "https://gist.github.com/aviflombaum/fd375100f4410dbbf184

# #ruby #homework"


# reading1.save
# reading2.save
# reading3.save