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
    JSON.parse(response.to_str).map { |e| Departure.new(e) }
  end

  class Departure
    attr_reader :line, :direction, :relative_time

    def initialize(data)
      @line = data[0]
      @direction = data[1]
      @relative_time = data[2].to_i
    end

    def time
      Time.now + @relative_time * 60
    end
  end

end
