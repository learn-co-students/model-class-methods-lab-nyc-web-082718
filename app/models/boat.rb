require 'pry'

class Boat < ActiveRecord::Base

# Relationships
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


# Methods
  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length > 20")
  end

  def self.last_three_alphabetically
    all.order('name DESC').limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    # binding.pry
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:boat_classifications).group("boat_classifications.boat_id").having("count(*) = 3")
  end
end
