require_relative '../../lib/zip_geo_jp/rake_helper'

namespace :zip_geo_ja do
  desc 'Update zip_geo_ja records'
  task :update do
    ZipGeoJp::RakeHelper.update
  end

  desc 'Clean zip_geo_ja records'
  task :reset do
    ZipGeoJp::RakeHelper.reset
  end
end
