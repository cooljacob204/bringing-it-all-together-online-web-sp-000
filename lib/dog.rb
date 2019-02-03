class Dog
  attr_accessor :id, :name, :breed
  def initialize(name, id=nil)
    @id = id
    @name = name
  end
end