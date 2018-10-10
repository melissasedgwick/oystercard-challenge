require 'journey'

describe Journey do
  subject { Journey.new(card) }
  let(:card) { double :card, :balance => 10, :deduct => '' }
  let(:card_no_balance) { double :card, :balance => 0 }
  let(:station) { double :station }
  let(:station2) { double :station }

  before :each do
    @journey_empty = Journey.new(card_no_balance)
  end

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'shows in journey as true' do
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'raises error when trying to touch in with less than MIN_FARE funds' do
      expect { @journey_empty.touch_in(station) }.to raise_error("Error: less than MIN_FARE fare of £#{Journey::MIN_FARE}")
    end

    it 'shows entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

  end

  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'shows in journey as false' do
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.in_journey?).to eq(false)
    end

    # it 'deducts fare from balance' do
    #   subject.touch_in(station)
    #   expect{ subject.touch_out(station2) }.to change{ card.balance }.by -(Oystercard::MIN_FARE)
    # end

    it 'shows the exit station' do
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.exit_station).to eq(station2)
    end

  end

  describe '#in_journey' do

    it { is_expected.to respond_to(:in_journey?) }

    it 'returns a boolean' do
      expect(subject.in_journey?).to eq(false).or(eq(true))
    end

  end

    describe '#entry_station' do

      it { is_expected.to respond_to(:entry_station) }

      it 'stores the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq(station)
      end

    end

    describe '#previous_journey' do

      it 'should show no history by default' do
        expect(subject.previous_journey).to be_empty
      end

      it 'stores journey history' do
        subject.touch_in(station)
        subject.touch_out(station2)
        expect(subject.previous_journey).to eq({entry_station: station, exit_station: station2})
      end

      it 'adds journey to all journeys' do
        subject.touch_in(station)
        subject.touch_out(station2)
        expect(subject.all_journeys).to include subject.previous_journey
      end

    end

  describe '#fare' do

    it 'returns MIN_FARE fare for complete journey' do
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.fare).to eq(Journey::MIN_FARE)
    end

    it 'returns penalty fare if card does not touch in' do
      subject.touch_out(station2)
      expect(subject.fare).to eq(Journey::PENALTY)
    end

    it 'returns penalty fare if card does not touch out' do
      subject.touch_in(station)
      expect(subject.fare).to eq(Journey::PENALTY)
    end

    it 'clears previous entry station after returning fare' do
      subject.touch_in(station)
      subject.touch_out(station2)
      subject.fare
      expect(subject.previous_journey[:entry_station]).to eq nil
    end

    it 'clears previous exit station after returning fare' do
      subject.touch_in(station)
      subject.touch_out(station2)
      subject.fare
      expect(subject.previous_journey[:exit_station]).to eq nil
    end

  end
  
end
