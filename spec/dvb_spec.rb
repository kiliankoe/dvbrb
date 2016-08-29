require 'spec_helper'

describe DVB do
  it 'has a version number' do
    expect(DVB::VERSION).not_to be nil
  end

  it 'can monitor stops' do
    expect(DVB::monitor('albertplatz')).not_to be nil
  end
end

describe DVB::Departure do
  it 'can be initialized with data array' do
    dep = DVB::Departure.new(['85', 'Löbtau Süd', '5'])
    expect(dep.line).to eq('85')
    expect(dep.direction).to eq('Löbtau Süd')
    expect(dep.relativeTime).to eq(5)
  end

  it 'gives the correct departure time' do
    dep = DVB::Departure.new(['85', 'Löbtau Süd', '5'])
    offset = Time.now + 5 * 60
    expect(dep.time.min).to eq(offset.min)
  end
end
