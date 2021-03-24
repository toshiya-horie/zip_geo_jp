require 'zip_geo_jp/version'
require 'zip_geo_jp/record'

module ZipGeoJp

  class << self

    # Convert zip code to latitude/longitude
    #
    # @param [String] zip_code
    # @return [Record]
    def [](zip_code)
      ZipGeoJp::Record[zip_code.unicode_normalize(:nfkc).sub('-', '')]
    end

  end
end
