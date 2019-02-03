class Dog
  attr_accessor :id, :name
  def initialize(name, id=nil)
    @id = id
    @name = name
  end
end