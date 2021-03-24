require_relative 'lib/zip_geo_jp/version'

Gem::Specification.new do |spec|
  spec.name          = 'zip_geo_jp'
  spec.version       = ZipGeoJp::VERSION
  spec.authors       = ['Toshiya Horie']
  spec.email         = ['toshiya.horie@gmail.com']

  spec.summary       = 'Convert Japanese zip code to coordinates.'
  spec.description   = spec.summary
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  spec.homepage      = 'https://github.com/toshiya-horie/zip_geo_jp'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.add_dependency 'sqlite3'
end
