class Journey
  MIN_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station, :previous_journey, :all_journeys

  def initialize(card = Oystercard.new)
    @previous_journey = {}
    @all_journeys = []
    @card = card
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Error: less than MIN_FARE fare of £#{MIN_FARE}" if @card.balance < MIN_FARE
    @previous_journey[:entry_station] = station
    @entry_station = station
  end

  def touch_out(station)
    @previous_journey[:exit_station] = station
    @all_journeys << @previous_journey
    @entry_station = nil
    @exit_station = station
  end

  def fare
    @previous_journey.length < 2 ? fare = PENALTY : fare = MIN_FARE
    @previous_journey.clear
    return fare
  end
end
