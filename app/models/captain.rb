class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins({:boats => :classifications}).where('classifications.name = ?', "Catamaran").uniq
  end

  def self.sailors
    joins({:boats => :classifications}).where('classifications.name = ?', "Sailboat").uniq
  end

  def self.motorboaters
    all.joins({:boats => :classifications}).where('classifications.name = ?', "Motorboat").uniq
  end

  def self.talented_seafarers
    where(:id => (self.sailors & self.motorboaters))
  end

  def self.non_sailors
    where.not(:id => self.sailors)
  end

end
