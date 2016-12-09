require('pg')

class SqlRunner

  def self.run(sql_string)
    begin
      db = PG.connect({dbname: 'cinemadb', host: 'localhost'})
      result = db.exec(sql_string)
    ensure
      db.close()
    end
    return result
  end

end