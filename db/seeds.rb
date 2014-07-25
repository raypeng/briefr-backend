# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tech = Category.create( { name: 'tech' } )
biz = Category.create( { name: 'biz' } )
life = Category.create( { name: 'lifestyle' } )

s1 = Story.create( { tweet_id: 489815471382736897, teller_username: 'tim_cook',
                     short_url: 'http://t.co/tOcfNQhUDn', category: tech } )
s2 = Story.create( { tweet_id: 490306429585092608, teller_username: 'rayrpeng',
                     short_url: 'http://t.co/rXEclJ54yV', category: tech } )
s3 = Story.create( { tweet_id: 471597689704939521, teller_username: 'CMSFreiberufler',
                     short_url: 'http://t.co/ZlA85AS0b4', category: tech } )
s4 = Story.create( { tweet_id: 491282774352211970, teller_username: 'MIT',
                     short_url: 'http://t.co/3OgKKIq6G3', category: tech } )

# this is a removed link, which generates socket error
# will come back later to handle exceptions
s5 = Story.create( { tweet_id: 491265996414390273, teller_username: 'techreview',
                     short_url: 'http://t.co/oJn6yx0YPc', category: tech } )
# this is used to test bad links
#                     short_url: 'http://fuck.shit', category: tech } )
#                     short_url: 'http://t.co/97TzQRuoDv', category: tech } )


s6 = Story.create( { tweet_id: 491916694127140864, teller_username: 'ReutersBiz',
                     short_url: 'http://t.co/PCRpWpGHMe', category: biz } )

s7 = Story.create( { tweet_id: 491749840041148419, teller_username: 'KitchenDailyCa',
                     short_url: 'http://t.co/yF3Wlk2Mw4', category: life } )

# this creates a layout mess
# s8 = Story.create( { tweet_id: 491933267705098240, teller_username: 'KitchenDailyCa',
#                      short_url: 'http://t.co/ZKbSpL1VBb', category: life } )

t1 = Teller.create( { username: 'WIRED', category: tech } )
t2 = Teller.create( { username: 'googledevs', category: tech } )
# t3 = Teller.create( { username: 'tim_cook', category: tech } )
# t4 = Teller.create( { username: 'techreview', category: tech } )

b1 = Teller.create( { username: 'BBCBusiness', category: biz } )
b2 = Teller.create( { username: 'ReutersBiz', category: biz } )
# b3 = Teller.create( { username: 'BloombergNews', category: biz } )
# b4 = Teller.create( { username: 'BenChu_', category: biz } )

l1 = Teller.create( { username: 'toscareno', category: life } )
l2 = Teller.create( { username: 'HuffPostCaLiv', category: life } )
# l3 = Teller.create( { username: 'KitchenDailyCa', category: life } )
# l4 = Teller.create( { username: 'massimoBRUNO', category: life } )
