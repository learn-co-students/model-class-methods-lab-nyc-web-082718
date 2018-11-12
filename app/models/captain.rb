require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'} AND classifications: {name: 'Motorboat'}).uniq
  end

  def self.non_sailors
    self.joins(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
  end
end
