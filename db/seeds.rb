# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def populate_stats(location)
  water_level = 250

  (1..4).to_a.reverse.each do |d|
    time = d.days.ago.to_date.to_datetime
    water_level = 250 if d != 2

    toilet_count = 0
    wash_basin_count = 0

    toilet_seed = (1 .. (10..15).to_a.sample).to_a
    wash_basin_seed = (1 .. (5..8).to_a.sample).to_a
    water_level_seed = (1..15).to_a

    (1..24).each do |i|
      time = time + 59.minutes
      water_level = water_level - water_level_seed.sample
      water_level = 0 if water_level < 0
      
      toilet_count = toilet_count + toilet_seed.sample
      wash_basin_count = wash_basin_count + wash_basin_seed.sample

      Stat.create location: location, time: time, toilet_count: toilet_count, wash_basin_count: wash_basin_count, water_level: water_level
    end
  end
end

populate_stats Location.create name: 'MOA2012', description: 'MOA', latitude: 0.345244, longitude: 32.597626 if Location.find_by_name('SANHACK2012').nil?
populate_stats Location.create name: 'UNICEF', description: 'UNICEF Office', latitude: 0.323526, longitude: 32.625318 if Location.find_by_name('UNICEF').nil?

User.create email: 'sanhack@sanhack.com', password: 'sanhack', password_confirmation: 'sanhack'

puts 'Database seeded'
