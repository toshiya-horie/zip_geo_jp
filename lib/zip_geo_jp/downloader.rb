require 'open-uri'

module ZipGeoJp
  class Downloader

    attr_accessor :url, :local_dir

    def initialize(url, local_dir)
      @url       = url
      @local_dir = local_dir
    end

    def filename
      @filename ||= URI.parse(url).path.to_s.split('/').last
    end

    def local
      File.join(@local_dir, filename)
    end

    def remove
      FileUtils.remove_file local if File.exist? local
    end

    def downloaded?
      File.exist? local
    end

    def download
      FileUtils.mkdir_p(@local_dir)
      open(@url) do |stream|
        open(local, 'w+b') do |file|
          file.write(stream.read)
        end
      end
    end
  end
end
