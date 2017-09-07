class OysterCard
  attr_accessor :balance, :in_journey
  attr_reader :entry, :list_of_journeys

  MAXIMUM = 100

  def initialize
    @balance = 0
    @list_of_journeys = [{}]
  end

  def top_up(amount)
    raise "#{MAXIMUM} is over your allowed top-up limit" if (@balance + amount) >= MAXIMUM
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'You have an insufficient balance' if @balance < 1
    @entry = entry_station
    @in_journey = true
  end

  def touch_out(exit_station)
    @list_of_journeys << {:entry => @entry, :exit => exit_station}
    @balance -= 1
    @in_journey = false
    @entry = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
