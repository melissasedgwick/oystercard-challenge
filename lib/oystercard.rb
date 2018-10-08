class Oystercard

  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Top up balance exceeds £#{LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Error: less than minimum fare of £#{MINIMUM}" if @balance < MINIMUM
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM)
    @in_journey = false
  end

  private :deduct

end
