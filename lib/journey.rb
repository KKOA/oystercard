class Journey

  MIN_FEE = 1
  MAX_FEE = 6


attr_reader :last_journey

  # in_journey


  # def initialize(entry,exit)

  # end

  def initialize (entry_station=:no_data,exit_station=:no_data)
    @last_journey = {:entry_station => entry_station ,:exit_station => exit_station }
  end


end
