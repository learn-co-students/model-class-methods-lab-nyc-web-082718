require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # self.joins(:boats => :classifications).where(name: "Catamaran")
    # self.all.joins(boats: [{classifications: {name: "Catamaran"}}])
    self.all.joins(boats: :classifications).where(:classifications => {:name => 'Catamaran'})
    #binding.pry
    # self.all.includes(:boats).includes(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.all.joins(boats: :classifications).where(:classifications => {:name => 'Sailboat'}).distinct
  end

  def self.motorboaters
    self.all.joins(boats: :classifications).where(:classifications => {:name => 'Motorboat'}).distinct
  end

  def self.talented_seafarers
    #binding.pry
    where(:id => (self.sailors & self.motorboaters))
  end

  def self.non_sailors
    where.not(:id => self.sailors)
  end
end
