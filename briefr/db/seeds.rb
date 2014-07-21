# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tech = Category.create( { name: 'Tech' } )
s1 = Story.create( { tweet_id: 489815471382736897, teller_username: 'tim_cook',
                     short_url: 'http://t.co/tOcfNQhUDn', category: tech } )
s2 = Story.create( { tweet_id: 490306429585092608, teller_username: 'rayrpeng',
                     short_url: 'http://t.co/rXEclJ54yV', category: tech } )
s3 = Story.create( { tweet_id: 471597689704939521, teller_username: 'CMSFreiberufler',
                     short_url: 'http://t.co/ZlA85AS0b4', category: tech } )
