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
s4 = Story.create( { tweet_id: 491265996414390273, teller_username: 'techreview',
                     short_url: 'http://t.co/oJn6yx0YPc', category: tech } )
s5 = Story.create( { tweet_id: 491282774352211970, teller_username: 'MIT',
                     short_url: 'http://t.co/3OgKKIq6G3', category: tech } )

t1 = Teller.create( { username: 'WIRED', category: tech } )
t2 = Teller.create( { username: 'googledevs', category: tech } )
t3 = Teller.create( { username: 'techreview', category: tech } )
