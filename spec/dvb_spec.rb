require 'spec_helper'

describe DVB do
  it 'has a version number' do
    expect(DVB::VERSION).not_to be nil
  end

  it 'can monitor stops' do
    expect(DVB::monitor('albertplatz')).not_to be nil
  end
end
