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
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS dogs"
    DB[:conn].execute(sql)
  end
  
  def save
    if @id
      sql = <<-SQL
        UPDATE dogs SET name=?, breed=? WHERE id=?
        SQL
        DB[:conn].execute(sql, @name, @breed, @id)
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed) 
        VALUES (?, ?)
      SQL
  
      DB[:conn].execute(sql, @name, @breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end
end