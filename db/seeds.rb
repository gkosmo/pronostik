# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'Bob')

Question.destroy_all

Category.destroy_all
Tag.destroy_all
cat = Category.new(title: 'Politics')
cat.save
cat = Category.new(title: 'Sports')
cat.save
cat = Category.new(title: 'Technology')
cat.save
cat = Category.new(title: 'Entertainment')
cat.save
cat = Category.new(title: 'Science')
cat.save
cat = Category.new(title: 'Society')
cat.save!




a = Question.new( user_id: User.all.sample.id, category_id: Category.all.sample.id, event_date: "Mon, 01 Jan 2018", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will Erdogan still be in power in the end of 2017 ?")
b = Question.new( user_id: User.all.sample.id,  category_id: Category.all.sample.id, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Shall Trump backout of the election ?")
c = Question.new( user_id: User.all.sample.id,  category_id: Category.all.sample.id, event_date: "Mon, 23 Sep 2016", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will the UK take home the most Olympic Medals this year ?")
d = Question.new( user_id: User.all.sample.id,  category_id: Category.all.sample.id, event_date: "Mon, 23 Jan 2021", created_at: "Tue, 23 Aug 2015 09:43:25 UTC +00:00", content: "Shall the auto-free zone around the Beurs be preserved in the next 5 years ? ")
a.scenarios.build(content: 'yes')
a.scenarios.build(content: 'no')
b.scenarios.build(content: 'yes')
b.scenarios.build(content: 'no')
c.scenarios.build(content: 'yes')
c.scenarios.build(content: 'no')
d.scenarios.build(content: 'yes')
d.scenarios.build(content: 'no')

d.tags.build(title: 'BELGIUM')
c.tags.build(title: 'UK')
b.tags.build(title: 'USA')
c.tags.build(title: 'TURKEY')
a.save!
b.save!
c.save!
d.save!




bet = Scenario.first
bet = Bet.new(scenario_id: bet.id, estimation: 44, user_id: User.all.sample.id)
bet.save
