require "pry"
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.joins(boats: :classifications).where(:classifications => {:name => 'Catamaran'})
  end

  def self.sailors
    all.joins(boats: :classifications).where(:classifications => {:name => 'Sailboat'}).distinct
  end

  def self.motorboaters
    all.joins(boats: :classifications).where(:classifications => {:name => 'Motorboat'}).distinct
  end

  def self.talented_seafarers
    where(:id => (self.sailors & self.motorboaters))
  end


  def self.non_sailors
    where.not(:id => (self.sailors))
  end

end

# binding.pry
