require 'oystercard'

describe OysterCard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { :entry => :station, :exit => :station } }

  it 'reads the balance to be 0' do
    start_balance = 0
    expect(subject.balance).to eq(start_balance)
  end

  describe '#top_up' do
    it 'can top up the oystercard' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'cannot exceed the top_up limit' do
      err_msg = "#{OysterCard::MAX_BALANCE} is over your allowed top-up limit"
      expect { subject.top_up(100) }.to raise_error(err_msg)
    end
  end

  it 'should deduct money from the balance' do
    subject.top_up(10)
    subject.send(:deduct, 5)
    expect(subject.balance).to eq(5)
  end

  it 'will deduct money from the oystercard when touched out' do
    subject.top_up(10)
    subject.touch_in(:entry_station) #changed
    expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-OysterCard::MIN_FEE)
  end

  it 'will deduct PENALTY from the oystercard when touched out' do
    subject.top_up(10)
    subject.touch_out(:exit_station)
    expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(-OysterCard::PENALTY)
  end



  it 'changes to journey state to true when touched in' do
    subject.top_up(10)
    subject.touch_in(:entry_station)
    expect(subject.in_journey).to be true
  end

  it 'changes the journey state to false when touched out' do
    subject.top_up(10)
    subject.touch_in(:entry_station)
    subject.touch_out(:exit_station)
    expect(subject.in_journey).to be false
  end

  describe '#touch_in' do
    it 'will throw an error with an insufficient balance' do
      err_msg = 'You have an insufficient balance'
      expect { subject.touch_in(:entry_station) }.to raise_error(err_msg)
    end
  end

  it 'remembers the entry station when user touches in' do
    subject.top_up(10)
    subject.touch_in(:entry_station)
    expect(subject.entry).to eq(:entry_station)
  end

  describe '#list_of_journeys' do
    it 'checks that there is an empty list of journeys by default' do
      expect(subject.list_of_journeys).to eq []
    end


  end
end
