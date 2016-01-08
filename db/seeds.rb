# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:first_name => "Pearly", :email => 'pearly@kenanddanadesign.com', :password => 'Mobikasa123', :password_confirmation => 'Mobikasa123')
User.create(:first_name => "Ankit", :email => 'ankit@mobikasa.com', :password => 'Mobikasa1', :password_confirmation => 'Mobikasa1')