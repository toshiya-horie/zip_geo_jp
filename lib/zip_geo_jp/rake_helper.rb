require 'parallel'
require 'zip'
require 'csv'
require 'uri'
require 'open-uri'
require 'nokogiri'
require_relative 'downloader'
require_relative 'record'

module ZipGeoJp
  module RakeHelper

    DOWNLOAD_URL_ENDPOINT           = 'https://www.post.japanpost.jp/zipcode/dl/oogaki/zip/'.freeze
    DOWNLOAD_URL_SUFFIX             = ['ken_all.zip'].freeze
    GOOGLE_MAP_CRAWLING_DURATION    = (ENV['GOOGLE_MAP_CRAWLING_DURATION'] || 1).to_f.freeze
    GOOGLE_MAP_CRAWLING_CONCURRENCY = (ENV['GOOGLE_MAP_CRAWLING_CONCURRENCY'] || 1).to_i.freeze

    class << self
      def update
        DOWNLOAD_URL_SUFFIX.map do |suffix|
          download_url = DOWNLOAD_URL_ENDPOINT + suffix
          records      = extract_zip_code(download_url)
          Parallel.each(records, in_threads: GOOGLE_MAP_CRAWLING_CONCURRENCY) do |zip_code, pref, city, block|
            puts "Item: #{zip_code} #{pref}#{city}#{block}, Worker: #{Parallel.worker_number}"
            unless ZipGeoJp::Record[zip_code]
              coordinates              = coordinates_from_google_map(zip_code)
              ZipGeoJp::Record[zip_code] = {
                  prefecture: pref,
                  city:       city,
                  block:      block,
                  latitude:   coordinates[0],
                  longitude:  coordinates[1],
              }
              sleep(GOOGLE_MAP_CRAWLING_DURATION)
            end
          end
        end
      end

      def reset
        ZipGeoJp::Record.reset
      end

      private

      def extract_zip_code(download_url)
        downloader = ZipGeoJp::Downloader.new(download_url, 'tmp')
        downloader.download unless downloader.downloaded?

        records = []
        Zip::File.open(downloader.local) do |zip_file|
          entry = zip_file.glob('*.CSV').first
          CSV.parse(
              entry.get_input_stream.read.encode(Encoding::UTF_8, Encoding::Shift_JIS),
          ).each do |rows|
            zipcode           = rows[2]
            pref, city, block = rows.slice(6, 3).map { |r| r.unicode_normalize(:nfkc) }
            records.push([zipcode, pref, city, block])
          end
        end

        records
      end

      def coordinates_from_google_map(zip_code)
        google_map_url  = "https://www.google.com/maps/place/%E3%80%92#{zip_code.gsub(/^(\d{3})(\d{4})$/, '\1-\2')}/"
        image_url       = Nokogiri::HTML(open(google_map_url).read).at('meta[itemprop="image"]')['content']
        coordinates_str = URI.parse(image_url).query.split('&').map { |kv| kv.split('=') }.to_h['center']
        URI.decode(coordinates_str).split(',').map(&:to_f)
      end
    end
  end
end
