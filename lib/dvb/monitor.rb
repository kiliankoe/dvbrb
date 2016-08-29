require 'rest-client'
require 'json'

module DVB

  def self.monitor(stop, offset = 0, lim = 0, city = 'Dresden')
    response = RestClient.get 'http://widgets.vvo-online.de/abfahrtsmonitor/Abfahrten.do',
      { params: {
        ort: city,
        hst: stop,
        vz: offset,
        lim: lim
      }}
    departures = JSON.parse(response.to_str).map { |e| Departure.new(e) }
  end

  class Departure
    attr_reader :line, :direction, :relativeTime

    def initialize(data)
      @line = data[0]
      @direction = data[1]
      @relativeTime = data[2].to_i
    end

    def time
      Time.now + @relativeTime * 60
    end
  end

end
