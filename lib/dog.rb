class Dog
  attr_accessor :id, :name, :breed
  def initialize(**attr)
    @id = attr[:id]
    @name = attr[:name]
    @breed = attr[:breed]
  end
  
  def self.create_table
    
  end
end