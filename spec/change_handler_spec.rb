# frozen_string_literal: true

require 'change_handler'
require 'value_calculator'

RSpec.describe ChangeHandler do
  let(:subject) { described_class.new(change_supply) }
  let(:change_supply) { { '1p': 50, '5p': 5 } }

  before do
    allow(ValueCalculator).to receive(:value_of).with(change_supply).and_return(0.75)
  end

  describe '#change_supply' do
    it 'returns the change supply' do
      expect(subject.change_supply).to eq(change_supply)
    end
  end

  describe '#add_change' do
    it 'increases the quantity of coins in supply' do
      subject.add_change({ '1p': 5, '10p': 2 })
      expect(subject.change_supply[:'1p']).to eq(55)
      expect(subject.change_supply[:'10p']).to eq(2)
    end
  end

  describe '#remove_change' do
    it 'decreases the quantity of coins in supply' do
      subject.remove_change({ '5p': 2 })
      expect(subject.change_supply[:'5p']).to eq(3)
    end
  end
end
