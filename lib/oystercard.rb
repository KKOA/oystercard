require_relative 'journey'

class OysterCard
  attr_accessor :balance, :in_journey
  attr_reader :entry, :list_of_journeys

  MAX_BALANCE  = 100
  MIN_FEE = 1
  PENALTY = 5

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
    @list_of_journeys << Journey.new(@entry, exit_station).last_journey
    @balance -= fare?
    @in_journey = false
    @entry = :no_data
  end

  def fare?
    # if yes ti-ti violation
    if @list_of_journeys.last[:entry_station] == :no_data
      PENALTY
    elsif @list_of_journeys.last[:exit_station] == :no_data
      PENALTY
    else
      MIN_FEE
    end
  end


  # {:entry_station => nil, :exit_station => nil}
  #
  # touch in and no touchout
  # {:entry_station => X, :exit_station => nil<-
  # penalty
  #
  # touch out and no touchin
  # {:entry_station => nil <-, :exit_station => Y}
  # penalty
  #


  private

  def deduct(amount)
    @balance -= amount
  end

end
