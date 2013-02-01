class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :description
  has_many :stats

  def to_param
    name
  end

  def latest_stat
    stats.last
  end

  def overall_stat
    Stat.new toilet_count: stats.sum(:toilet_count), wash_basin_count: stats.sum(:wash_basin_count)
  end

  def map?
    latitude > 0 and longitude > 0 rescue false
  end

end
