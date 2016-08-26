# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'Bob')
Bet.destroy_all

Question.destroy_all

Category.destroy_all
Tag.destroy_all

cat_politics      = Category.create!(title: 'Politics')
cat_sports        = Category.create!(title: 'Sports')
cat_tech          = Category.create!(title: 'Technology')
cat_entertainment = Category.create!(title: 'Entertainment')
cat_science       = Category.create!(title: 'Science')
cat_society       = Category.create!(title: 'Society')



a = Question.new( user_id: User.all.sample.id, category: cat_politics, event_date: "Mon, 01 Jan 2018", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will Erdogan still be in power in the end of 2017 ?")
b = Question.new( user_id: User.all.sample.id,  category: cat_politics, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Shall Trump backout of the election ?")
c = Question.new( user_id: User.all.sample.id,  category: cat_sports, event_date: "Mon, 23 Sep 2016", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will the UK take home the most Olympic Medals this year ?")
d = Question.new( user_id: User.all.sample.id,  category: cat_tech, event_date: "Mon, 23 Jan 2021", created_at: "Tue, 23 Aug 2015 09:43:25 UTC +00:00", content: "Shall the auto-free zone around the Beurs be preserved in the next 5 years ? ")
e = Question.new( user_id: User.all.sample.id,  category: cat_society, event_date: "Mon, 20 Jun 2016", created_at: "Tue, 28 Jun 2016 09:43:25 UTC +00:00", content: "Will Anneesens neighbourhood become gentrified? ")
f = Question.new( user_id: User.all.sample.id,  category: cat_tech, event_date: "Mon, 4 Apr 2016", created_at: "Tue, 31 May 2016 09:43:25 UTC +00:00", content: "Will more bourkini-bans be installed in Europe (outside of France? ")

a.scenarios.build(content: "No, Erdogan will be overtrown by 2017")
a.scenarios.build(content: "Yes, Erdogan will still be in power by 2017")

b.scenarios.build(content: 'yes')
b.scenarios.build(content: 'no')
c.scenarios.build(content: 'yes')
c.scenarios.build(content: 'no')
d.scenarios.build(content: 'yes')
d.scenarios.build(content: 'no')
e.scenarios.build(content: 'yes')
e.scenarios.build(content: 'no')
f.scenarios.build(content: 'yes')
f.scenarios.build(content: 'no')


d.tags.build(title: 'BELGIUM')
c.tags.build(title: 'UK')
b.tags.build(title: 'USA')
c.tags.build(title: 'TURKEY')

e.tags.build(title: 'EU')
f.tags.build(title: 'BRUSSELS')
e.tags.build(title: 'FRANCE')
e.tags.build(title: 'RELIGION')

a.save!
b.save!
c.save!
d.save!
e.save!
f.save!

bet = Scenario.first
bet = Bet.new(scenario_id: bet.id, estimation: 44, user_id: User.all.sample.id)
bet.save
