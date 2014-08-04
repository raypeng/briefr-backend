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

begin
  Teller.create( { username: 'arrington', category: tech } )
  Teller.create( { username: 'myoung', category: tech } )
  Teller.create( { username: 'gaberivera', category: tech } )
  Teller.create( { username: 'jimmy_wales', category: tech } )
  Teller.create( { username: 'Mazzeo', category: tech } )
  Teller.create( { username: 'levie', category: tech } )
  Teller.create( { username: 'gilgul', category: tech } )
  Teller.create( { username: 'Borthwick', category: tech } )
  Teller.create( { username: 'om', category: tech } )
  Teller.create( { username: 'michaelheywire', category: tech } )
  Teller.create( { username: 'satyanadella', category: tech } )
  Teller.create( { username: 'karaswisher', category: tech } )
  Teller.create( { username: 'dhinchcliffe', category: tech } )
  Teller.create( { username: 'dharmesh', category: tech } )
  Teller.create( { username: 'digiphile', category: tech } )
  
  # something wrong with this Jack, sorry buddy
  # Teller.create( { username: 'jack', category: tech } )

  Teller.create( { username: 'stevecase', category: biz } )
  Teller.create( { username: 'umairh', category: biz } )
  Teller.create( { username: 'benioff', category: biz } )
  Teller.create( { username: 'JohnsonWhitney', category: biz } )
  Teller.create( { username: 'danielpink', category: biz } )
  Teller.create( { username: 'nilofer', category: biz } )
  Teller.create( { username: 'moiraforbes', category: biz } )
  Teller.create( { username: 'garyvee', category: biz } )
  Teller.create( { username: 'markfidelman', category: biz } )
  Teller.create( { username: 'Ekaterina', category: biz } )
  Teller.create( { username: 'skgreen', category: biz } )
  Teller.create( { username: 'mitchjoel', category: biz } )
  Teller.create( { username: 'armano', category: biz } )

  Teller.create( { username: 'brenebrown', category: life } )
  Teller.create( { username: 'tonyrobbins', category: life } )
  Teller.create( { username: 'ChelseaClinton', category: life } )
  Teller.create( { username: 'AshleyJudd', category: life } )
  Teller.create( { username: 'jackandraka', category: life } )
  Teller.create( { username: 'DrNancyNBCNEWS', category: life } )
  Teller.create( { username: 'Laurie_Garrett', category: life } )
  Teller.create( { username: 'MaryMurrayNBC', category: life } )
  Teller.create( { username: 'JonnyVanMeter', category: life } )
  Teller.create( { username: 'dan_thawley', category: life } )
  Teller.create( { username: 'Lupita_Nyongo', category: life } )
  Teller.create( { username: 'JessicaMartino', category: life } )
  Teller.create( { username: 'CTurlington', category: life } )

rescue Exception => e
  p e.message
  p e.backtrace[0]
end
