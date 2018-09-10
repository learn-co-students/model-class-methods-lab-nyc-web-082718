class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:classifications).distinct.where("classifications.name = 'Sailboat'")
  end

  def self.motorboaters
    self.joins(:classifications).distinct.where("classifications.name = 'Motorboat'")
  end

  def self.talented_seafarers
    # binding.pry
    self.where(:id => (self.sailors & self.motorboaters))
  end

  def self.non_sailors
    self.where.not(:id => self.sailors)
  end

end
