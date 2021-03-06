module DVB
  def self.find(search_str, region = 'Dresden')
    all_stops = load_local_stops
    all_stops.select do |stop|
      # TODO: Improve the matching here. Something relatively fuzzy would awesome.
      search_str.downcase!
      (stop.name.downcase.include?(search_str) || stop.search_str.downcase.include?(search_str)) && stop.region == region
    end
    # The following would theoretically make sense, if priority values weren't so weird...
    # all_stops.sort_by { |s| s.priority }.reverse
  end

  def self.find_near(lat, lng, radius = 500)
    # Unfortunately some stops (exactly 100 of 4480) don't have location data associated with them
    # Filtering those out here, as they're not relevant for location-based searching
    all_stops = load_local_stops.reject { |s| s.lat.nil? || s.lng.nil? }
    all_stops.select do |stop|
      DVB::distance_between(stop.lat, stop.lng, lat, lng) <= radius
    end
  end

  def self.load_local_stops
    path = File.expand_path(File.dirname(__FILE__)) + '/VVOStops.json'
    JSON.parse(File.read(path)).map { |e| DVB::Stop.with_str_hash(e) }
  end

  class Stop
    attr_reader :id, :lat, :lng, :name, :priority, :region, :search_str, :tarif_zones

    def initialize(id, lat, lng, name, priority, region, search_str, tarif_zones)
      @id = id
      @lat = lat
      @lng = lng
      @name = name
      @priority = priority
      @region = region
      @search_str = search_str
      @tarif_zones = tarif_zones
    end

    def self.with_str_hash(h)
      lat = h['latitude'] == '999.999999' ? nil : h['latitude'].to_f
      lng = h['longitude'] == '999.999999' ? nil : h['longitude'].to_f
      Stop.new(h['id'], lat, lng, h['name'], h['priority'].to_i, h['region'], h['searchstring'], h['tarif_zones'])
    end

    def coords
      {
        latitude: @lat,
        longitute: @lng
      }
    end

    def to_s
      "#{@name}, #{@region}"
    end
  end
end
