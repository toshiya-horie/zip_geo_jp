# ZipGeoJp

Convert Japanese zip code to latitude/longitude.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zip_geo_jp'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install zip_geo_jp

## Usage

```
> ZipGeoJa['167-0021']
=> #<ZipGeoJp::Record:0x00007f941588c920 @zip_code="167-0021", @prefecture="東京都", @city="杉並区", @latitude=35.7276542, @longitude=139.6158849, @block="井草">
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/toshiya-horie/zip_geo_jp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/toshiya-horie/zip_geo_jp/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ZipGeoJp project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/toshiya-horie/zip_geo_jp/blob/master/CODE_OF_CONDUCT.md).
