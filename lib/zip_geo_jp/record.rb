require 'sqlite3'

module ZipGeoJp
  class Record
    attr_reader :zip_code, :prefecture, :city, :block, :latitude, :longitude

    def initialize(values)
      @zip_code                                         = values.shift.gsub(/^(\d{3})(\d{4})$/, '\1-\2')
      @prefecture, @city, @block, @latitude, @longitude = values
    end

    class << self
      def [] (key)
        row = db.execute('SELECT * FROM zip_codes WHERE zip_code = ? LIMIT 1', key).first
        row ? from_row(row) : nil
      end

      def []= (key, values)
        values[:zip_code] = key
        db.execute(
            'REPLACE INTO zip_codes(zip_code, prefecture, city, block, latitude, longitude) VALUES(:zip_code, :prefecture, :city, :block, :latitude, :longitude)',
            values
        )
        values
      end

      def reset
        File.delete(file) if File.exists?(file)
      end

      def from_row(row)
        new(row.values)
      end

      private

      def db
        @@db ||= begin
          db                 = SQLite3::Database.new(file)
          db.results_as_hash = true
          db.execute(<<_EOF_
          CREATE TABLE IF NOT EXISTS zip_codes (
           zip_code   TEXT NOT NULL PRIMARY KEY,
           prefecture TEXT NOT NULL,
           city       TEXT NOT NULL,
           block      TEXT,
           latitude   REAL,
           longitude  REAL
          )
_EOF_
          )
          db
        end
      end

      def file
        File.join(__dir__, '../../data/zip_geo_jp.sqlite3')
      end
    end
  end # Data
end # Zipja
