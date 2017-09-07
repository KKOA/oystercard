require 'station'
describe Station do
  it 'return name' do
    station = Station.new('kingcross', '1')
    expect(station.name).to eq 'kingcross'
  end

  it 'return zone number' do
    station = Station.new('kingcross', '1')
    expect(station.zone).to eq '1'
  end

end
