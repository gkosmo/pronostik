# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Question.destroy_all

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
cat.save


a = Question.new( user_id: 1,  category_id: 1, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will Erdogan still be in power next year?")
b = Question.new( user_id: 1,  category_id: 1, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Shall Trump backout the election?")
c = Question.new( user_id: 1,  category_id: 2, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Will the UK take home the most Olympic Medals this year?")
d = Question.new( user_id: 1,  category_id: 6, event_date: "Mon, 23 Jan 2017", created_at: "Tue, 23 Aug 2016 09:43:25 UTC +00:00", content: "Shall the auto-free zone around the Beurs continue be preserved?")

a.save
b.save
c.save
d.save
