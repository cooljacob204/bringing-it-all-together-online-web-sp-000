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
  
  def self.create(dog)
    new_dog = new(dog)
    new_dog.save
    new_dog
  end
  
  
  def self.find_by_id(id)
    sql = <<-SQL 
         SELECT * FROM dogs WHERE dogs.id==? LIMIT 1
       SQL
   student_row = DB[:conn].execute(sql, id)
   new_from_db(student_row[0])
  end
end