
require 'oystercard'

describe Journey do

  let(:oystercard) {double :oystercard}

  it 'adds a journey when initialized' do
    new_journey = Journey.new(:entry_station, :exit_station)
    expect(new_journey.last_journey).to include(:entry_station => :entry_station, :exit_station => :exit_station)
  end



end
