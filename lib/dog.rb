class Dog
  attr_accessor :id, :name, :breed
  def initialize(**attr)
    @id = attr[:id]
    @name = attr[:name]
    @breed = attr[:breed]
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end
end