require 'oystercard'

describe OysterCard do

 let(:entry_station) { double :station }
 let(:exit_station) {double :station }
 let(:journey) { {:entry => :station, :exit => :station} }

 it 'reads the balance to be 0' do
  expect(subject.balance).to eq(0)
 end

 it 'can top up the oystercard' do
  subject.top_up(5)
  expect(subject.balance).to eq(5)
 end

 it 'cannot exceed the top_up limit' do
  expect{subject.top_up(100)}.to raise_error("#{OysterCard::MAXIMUM} is over your allowed top-up limit")
 end

it 'should deduct money from the balance' do
  subject.top_up(10)
  subject.send(:deduct, 5)
  expect(subject.balance).to eq(5)
 end

it 'will deduct money from the oystercard when touched out' do
  subject.top_up(5)
  subject.send(:deduct, 5)
  expect{subject.touch_out(:station)}.to change{subject.balance}.by(-1)
end

it 'changes to journey state to true when touched in' do
  subject.top_up(10)
  kingscross = double
  subject.touch_in(:station)
  expect(subject.in_journey).to be true
end

it 'changes the journey state to false when touched out' do
  subject.top_up(10)
  kingscross = double
  subject.touch_in(:station)
  subject.touch_out(:station)
  expect(subject.in_journey).to be false
 end

it 'will throw an error with an insufficient balance' do
  kingscross = double
  expect{subject.touch_in(:station)}.to raise_error("You have an insufficient balance")
 end

it 'remembers the entry station when user touches in' do
  subject.top_up(5)
  subject.touch_in(:station)
  expect(subject.entry).to eq(:station)
 end

it 'checks that there is an empty list of journeys by default' do
  expect(subject.list_of_journeys).to eq [{}]
end

it 'adds a journey when touched in and out' do
   subject.top_up(10)
   subject.touch_in(:station)
   subject.touch_out(:station)
   expect(subject.list_of_journeys).to include(:entry => :station, :exit => :station)
   expect(subject.list_of_journeys).to include(journey)
end


end
