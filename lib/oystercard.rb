class OysterCard
  attr_accessor :balance, :in_journey
  attr_reader :entry, :list_of_journeys

  MAX_BALANCE  = 100
  MIN_FEE = 1

  def initialize
    @balance = 0
    @list_of_journeys = []
  end

  def top_up(amount)
    err_msg = "#{MAX_BALANCE} is over your allowed top-up limit"
    raise err_msg if (@balance + amount) >= MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    err_msg = 'You have an insufficient balance'
    raise err_msg if @balance < MIN_FEE
    @entry = entry_station
    @in_journey = true
  end

  def touch_out(exit_station)
    @list_of_journeys << new_journey(@entry, exit_station)
    @balance -= 1
    @in_journey = false
    @entry = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
