# Quintype::SEO

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quintype-seo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quintype-seo

## Usage

### Fetching meta tag data for a page

You can fetch data for each page in the following way:

Section:
```ruby
Quintype::Seo::Section.new(config, section).to_h
```

Home:
```ruby
Quintype::Seo::Home.new(config).to_h
```

Story:
```ruby
Quintype::Seo::Story.new(config, story).to_h
```

Search and Topic:
```ruby
Quintype::Seo::Search.new(config, search_term).to_h
Quintype::Seo::Tag.new(config, search_term).to_h
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quintype/quintype-seo-ruby.
