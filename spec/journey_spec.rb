require 'journey'

describe Journey do

  let(:oystercard) {double :oystercard}

  it 'adds a journey when touched in and out' do
    allow(oystercard).to receive(:touch_in).with(:entry_station)
    allow(oystercard).to receive(:touch_out).with(:exit_station)
    oystercard.touch_in(:entry_station)
    oystercard.touch_out(:exit_station)
    expect(subject.new_journey).to include(:entry => :entry_station, :exit => :exit_station)
  end

end
