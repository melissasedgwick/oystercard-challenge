require 'oystercard'

describe Oystercard do

  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

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

end
