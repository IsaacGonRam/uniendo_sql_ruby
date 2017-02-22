require 'sqlite3'

class Chef

  def initialize(first_name, last_name, birthday, email, phone, created_at = Time.now, updated_at = Time.now)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone =phone
    @created_at = created_at
    @updated_at = updated_at
  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
        -- Añade aquí más registros
          ('Isaac', 'Gonzalez', '1986-05-18', 'jah_razta86@hotmail.com', '5527541207', DATETIME('now'), DATETIME('now')),
          ('Roberto', 'Herrera', '1990-07-19', 'rherrerarami@gmail.com', '5512457856', DATETIME('now'), DATETIME('now')),
          ('Esteban', 'Gutierrez', '1985-02-09', 'estabangr@yahoo.com', '5523568956', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.all
    Chef.db.execute(
    <<-SQL
      
        SELECT * FROM chefs;
      
    SQL
    )
  end

  def self.where(columna,dato)
    Chef.db.execute(
    <<-SQL
      
        SELECT * FROM chefs WHERE "#{columna}" = "#{dato}";
        OR 
        SELECT * FROM chefs WHERE "#{columna}" = ?, "#{dato}";
      
    SQL
    ).each do |row|
      row.each do |otro|
        print "#{otro}    "
      end
    end
  end

  def save
    Chef.db.execute(
    <<-SQL
      INSERT INTO chefs (first_name, last_name, birthday, email, phone, created_at, updated_at)
      VALUES('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', '#{@created_at}', '#{@updated_at}')
      
    SQL
    )
  end

  def self.delete(columna,dato)
    Chef.db.execute(
    <<-SQL
      
        DELETE FROM chefs WHERE "#{columna}" = "#{dato}";
        # OR 
        # SELECT * FROM chefs WHERE '#{columna}' = ?, '#{dato}';
      
    SQL
    )      
  end


  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

#p Chef.all
Chef.where('id', 2)
# cocinero = Chef.new('Pedro', 'Stark', '1989-07-25', 'jah_razta86@hotmail.com', '5527541207')
# cocinero.save
# p Chef.all
# Chef.delete('id', 5)
# p Chef.all










