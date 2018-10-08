class Oystercard

  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :all_journeys

  def initialize
    @balance = 0
    @journey_history = {}
    @all_journeys = []
  end

  def top_up(amount)
    raise "Top up balance exceeds £#{LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "Error: less than minimum fare of £#{MINIMUM}" if @balance < MINIMUM
    @journey_history[:entry_station] = station
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM)
    @journey_history[:exit_station] = station
    @all_journeys << @journey_history
    @entry_station = nil
    @exit_station = station
  end

  private :deduct

end
