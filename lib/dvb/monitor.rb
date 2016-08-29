require 'rest-client'
require 'json'

require_relative 'utils'

module DVB

  def self.monitor(stop, offset = 0, lim = 0, city = 'Dresden')
    response = RestClient.get 'http://widgets.vvo-online.de/abfahrtsmonitor/Abfahrten.do',
      { params: {
        ort: city,
        hst: stop,
        vz: offset,
        lim: lim
      }}
    JSON.parse(response.to_str).map { |e| Departure.with_arr(e) }
  end

  class Departure
    attr_reader :line, :direction, :relative_time

    def self.with_arr(data)
      Departure.new(data[0], data[1], data[2].to_i)
    end

    def initialize(line, direction, relative_time)
      @line = line
      @direction = direction
      @relative_time = relative_time
    end

    def time
      Time.now + @relative_time * 60
    end

    def mode
      DVB::parse_mode(@line)
    end

    def to_s
      "#{@line} #{direction} @ #{time}"
    end
  end

end
