require 'oystercard'

describe 'User stories' do

  it 'shows money on card' do
    # In order to use public transport
    # As a customer
    # I want money on my card
    card = Oystercard.new
    expect { card.balance }.not_to raise_error
  end

  it 'lets me add money' do
    # In order to keep using public transport
    # As a customer
    # I want to add money to my card
    card = Oystercard.new
    expect { card.top_up(10) }.not_to raise_error
  end

  it 'stops me adding more than £90 to the card' do
    # In order to protect my money from theft or loss
    # As a customer
    # I want a maximum limit (of £90) on my card
    card = Oystercard.new
    expect { card.top_up(91) }.to raise_error
  end

  # it 'deducts money from card' do
  #   # In order to pay for my journey
  #   # As a customer
  #   # I need my fare deducted from my card
  #   card = Oystercard.new
  #   expect { card.deduct(10) }.not_to raise_error
  # end

  it 'allows me to touch in and out' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("Station")
    card.touch_out("Station2")
    expect { card.in_journey? }.not_to raise_error
  end

  it 'does not let me touch in if I have less than the minimum funds' do
    #In order to pay for my journey
    #As a customer
    #I need to have the minimum amount (£1) for a single journey.
    card = Oystercard.new
    expect { card.touch_in("Station") }.to raise_error
  end

  it 'deducts balance when touching out' do
    # In order to pay for my journey
    # As a customer
    # When my journey is complete, I need the correct amount deducted from my card
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("Station")
    card.touch_out("Station2")
    expect(card.balance).to eq(10 - Oystercard::MINIMUM)
  end

  it 'remembers the entry station' do
    # In order to pay for my journey
    # As a customer
    # I need to know where I've travelled from
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("Station")
    expect(card.entry_station).to eq("Station")
  end

  it 'remembers all previous journeys' do
    # In order to know where I have been
    # As a customer
    # I want to see all my previous trips
    card = Oystercard.new
    card.top_up(10)
    card.touch_in("Station1a")
    card.touch_out("Station1b")
    expect(card.journey_history).to eq({entry_station: "Station1a", exit_station: "Station1b"})
  end

end
