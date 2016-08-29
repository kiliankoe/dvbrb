require 'spec_helper'

describe DVB do
  it 'has a version number' do
    expect(DVB::VERSION).not_to be nil
  end
end

describe 'Monitor "Postplatz"' do
  departures = DVB::monitor('postplatz')

  it 'returns data' do
    expect(departures).not_to be nil
    expect(departures.count).not_to eq(0)
  end
end

describe 'Monitor "XXX"' do
  departures = DVB::monitor('XXX')

  it 'returns empty list of departures' do
    expect(departures).not_to be nil
    expect(departures.count).to eq(0)
  end
end

describe DVB::Departure do
  it 'can be initialized with data array' do
    dep = DVB::Departure.with_arr(['85', 'Löbtau Süd', '5'])
    expect(dep.line).to eq('85')
    expect(dep.direction).to eq('Löbtau Süd')
    expect(dep.relative_time).to eq(5)
  end

  it 'has the correct departure time' do
    dep = DVB::Departure.new('85', 'Löbtau Süd', 5)
    offset = Time.now + 5 * 60
    expect(dep.time.min).to eq(offset.min)
  end

  it 'has the correct transport mode' do
    dep = DVB::Departure.new('85', 'Löbtau Süd', 5)
    expect(dep.mode).to eq(DVB::TransportMode::CITYBUS)
  end
end

describe 'Parse Transport Mode' do
  it 'should identify correct values as `Straßenbahn`' do
    expect(DVB::parse_mode('3')).to eq(DVB::TransportMode::TRAM)
    expect(DVB::parse_mode('11')).to eq(DVB::TransportMode::TRAM)
    # Trams exist up to 59, everything from 60 on upwards should be a bus.
    expect(DVB::parse_mode('59')).to eq(DVB::TransportMode::TRAM)
    # Unfortunately trying to specify if these are buses or trams with any
    # kind of certainty is not really possible. This lib therefore defaults
    # to what the original non-replacement line would've probably been.
    expect(DVB::parse_mode('E8')).to eq(DVB::TransportMode::TRAM)
    expect(DVB::parse_mode('E11')).to eq(DVB::TransportMode::TRAM)
    expect(DVB::parse_mode('85')).not_to eq(DVB::TransportMode::TRAM)
  end

  it 'should identify correct values as `Stadtbus`' do
    expect(DVB::parse_mode('85')).to eq(DVB::TransportMode::CITYBUS)
    expect(DVB::parse_mode('99')).to eq(DVB::TransportMode::CITYBUS)
    expect(DVB::parse_mode('60')).to eq(DVB::TransportMode::CITYBUS)
    expect(DVB::parse_mode('E75')).to eq(DVB::TransportMode::CITYBUS)
    # Three-digit-identifiers should be reserved for regional buses
    expect(DVB::parse_mode('100')).not_to eq(DVB::TransportMode::CITYBUS)
  end

  it 'should identify correct values as `Regionalbus`' do
    expect(DVB::parse_mode('366')).to eq(DVB::TransportMode::REGIOBUS)
    expect(DVB::parse_mode('999')).to eq(DVB::TransportMode::REGIOBUS)
    expect(DVB::parse_mode('100')).to eq(DVB::TransportMode::REGIOBUS)
    # Single letter identifiers for regional buses exist $somewhere in
    # the VVO network outside of Dresden.
    expect(DVB::parse_mode('A')).to eq(DVB::TransportMode::REGIOBUS)
    expect(DVB::parse_mode('Z')).to eq(DVB::TransportMode::REGIOBUS)
    # These two exist only with exactly these identifiers.
    expect(DVB::parse_mode('G/L')).to eq(DVB::TransportMode::REGIOBUS)
    expect(DVB::parse_mode('H/S')).to eq(DVB::TransportMode::REGIOBUS)
    expect(DVB::parse_mode('85')).not_to eq(DVB::TransportMode::REGIOBUS)
  end

  it 'should identify correct values as `Seil-/Schwebebahn`' do
    expect(DVB::parse_mode('SWB')).to eq(DVB::TransportMode::LIFT)
    expect(DVB::parse_mode('S3')).not_to eq(DVB::TransportMode::LIFT)
  end

  it 'should identify correct values as `Fähre`' do
    expect(DVB::parse_mode('F7')).to eq(DVB::TransportMode::FERRY)
    expect(DVB::parse_mode('F14')).to eq(DVB::TransportMode::FERRY)
    expect(DVB::parse_mode('E14')).not_to eq(DVB::TransportMode::FERRY)
  end

  it 'should identify correct values as `Zug`' do
    expect(DVB::parse_mode('ICE 1717')).to eq(DVB::TransportMode::TRAIN)
    expect(DVB::parse_mode('IC 1717')).to eq(DVB::TransportMode::TRAIN)
    expect(DVB::parse_mode('RB 1717')).to eq(DVB::TransportMode::TRAIN)
    expect(DVB::parse_mode('TLX 1717')).to eq(DVB::TransportMode::TRAIN)
    # "Sächsische Städtebahn"
    expect(DVB::parse_mode('SB33')).to eq(DVB::TransportMode::TRAIN)
    # "Wintersport Express" o.O
    expect(DVB::parse_mode('SE19')).to eq(DVB::TransportMode::TRAIN)
    # fares between Bad Schandau and Děčín
    expect(DVB::parse_mode('U28')).to eq(DVB::TransportMode::TRAIN)
    expect(DVB::parse_mode('S 1717')).not_to eq(DVB::TransportMode::TRAIN)
  end

  it 'should identify correct values as `S-Bahn`' do
    expect(DVB::parse_mode('S3')).to eq(DVB::TransportMode::METROPOLITAN)
    expect(DVB::parse_mode('S 1717')).to eq(DVB::TransportMode::METROPOLITAN)
    expect(DVB::parse_mode('IC 1717')).not_to eq(DVB::TransportMode::METROPOLITAN)
    expect(DVB::parse_mode('RB 1717')).not_to eq(DVB::TransportMode::METROPOLITAN)
  end

  it 'should identify correct values as `Rufbus`' do
    expect(DVB::parse_mode('alita')).to eq(DVB::TransportMode::AST)
    expect(DVB::parse_mode('alita 95')).to eq(DVB::TransportMode::AST)
    expect(DVB::parse_mode('95')).not_to eq(DVB::TransportMode::AST)
  end

  it 'should fail with `null`' do
    expect(DVB::parse_mode('Lorem Ipsum')).to eq(nil)
  end
end
