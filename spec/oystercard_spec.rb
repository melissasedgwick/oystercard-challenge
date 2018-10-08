require 'oystercard'

describe Oystercard do

  describe '#balance' do

    it "has a balance of 0 when created" do
      expect(subject.balance).to eq(0)
    end

  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect { subject.top_up(1)}.to change{ subject.balance }.by 1
    end

    it 'raises error when trying to add more than £90' do
      maximum_balance = Oystercard::LIMIT
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error("Top up balance exceeds £#{maximum_balance} limit")
    end

  end

  # describe '#deduct' do
  #
  #   it { is_expected.to respond_to(:deduct).with(1).argument }
  #
  #   it 'deducts an amount from the balance' do
  #     subject.top_up(20)
  #     expect{ subject.deduct 3}.to change{ subject.balance }.by -3
  #   end
  #
  # end

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in) }

    it 'shows in journey as true' do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey).to eq(true)
    end

    it 'raises error when trying to touch in with less than minimum funds' do
      expect { subject.touch_in }.to raise_error("Error: less than minimum fare of £#{Oystercard::MINIMUM}")
    end

  end

  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out) }

    it 'shows in journey as false' do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end

    it 'deducts fare from balance' do
      subject.top_up(10)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by -(Oystercard::MINIMUM)
    end

  end

  describe '#in_journey' do

    it { is_expected.to respond_to(:in_journey) }

    it 'returns a boolean' do
      expect(subject.in_journey).to eq(false).or(eq(true))
    end

  end

end
