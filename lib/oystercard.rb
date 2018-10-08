class Oystercard

  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
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
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM)
    @entry_station = nil
  end

  private :deduct

end
