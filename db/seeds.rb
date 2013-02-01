# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def populate_stats(location, spikes=4)
  water_level = 250

  (1..spikes).to_a.reverse.each do |d|
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

populate_stats Location.create(name: 'School', description: 'School', latitude: 0.338035, longitude: 32.598235), 30 if Location.find_by_name('School').nil?
populate_stats Location.create(name: 'Hospital', description: 'Hospital', latitude: 0.323526, longitude: 32.625318), 15 if Location.find_by_name('Hospital').nil?
populate_stats Location.create(name: 'Public Toilet', description: 'Public Toilet', latitude: 0.313611, longitude: 32.581111), 20 if Location.find_by_name('Public Toilet').nil?
populate_stats Location.create(name: 'Office', description: 'Office', latitude: 0.338152, longitude: 32.575882), 10 if Location.find_by_name('Office').nil?

User.create email: 'sanhack@sanhack.com', password: 'sanhack', password_confirmation: 'sanhack'

puts 'Database seeded'
