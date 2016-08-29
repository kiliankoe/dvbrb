# DVB

[![Gem](https://img.shields.io/gem/v/dvb.svg?style=flat-square)](https://rubygems.org/gems/dvb)[![Travis](https://img.shields.io/travis/kiliankoe/dvbrb.svg?style=flat-square)](https://travis-ci.org/kiliankoe/dvbrb/builds)[![GitHub issues](https://img.shields.io/github/issues/kiliankoe/dvbrb.svg?style=flat-square)](https://github.com/kiliankoe/dvbrb/issues)[![Gemnasium](https://img.shields.io/gemnasium/kiliankoe/dvbrb.svg?style=flat-square)](https://gemnasium.com/github.com/kiliankoe/dvbrb)

This is an unofficial gem giving you a few options to query Dresden's public transport system for current bus- and tramstop data.

Similar libs also exist for [Node](https://github.com/kiliankoe/dvbjs), [Python](https://github.com/kiliankoe/dvbpy) and [Swift](https://github.com/kiliankoe/DVB) 😊

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dvb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dvb
## Usage

Calling the following will return a list of `DVB::Departure` objects encapsulating information about upcoming departures at the given stop.

```ruby
DVB::monitor('helmholtzstrasse')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kiliankoe/dvbrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## Why?

At this point I consider writing wrappers for the DVB/VVO APIs as somewhat of an extensive hello-world exercise for myself. I'm trying to get back into Ruby and realized I've never published a gem, so here goes nothing 😄
