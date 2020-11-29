# frozen_string_literal: true

require 'services/change_calculator'

RSpec.describe ChangeCalculator do
  let(:subject) { described_class }

  describe '#call' do
    context 'when the change supply is able to supply exact change with one coin' do
      let(:change_to_return) { 50 }
      let(:change_supply) { { '50p': 5 } }

      it 'returns an object cointaining a single coin' do
        expect(subject.call(change_to_return, change_supply)).to eq({ '50p': 1 })
      end
    end

    context 'when the change to return includes multiple coins' do
      let(:change_to_return) { 57 }
      let(:change_supply) { { '1p': 2, '5p': 1, '50p': 1 } }

      it 'returns an object containing multiple different coins' do
        expect(subject.call(change_to_return, change_supply)).to eq({ '50p': 1, '5p': 1, '1p': 2 })
      end
    end

    context 'when the change supply is limited by particular coin supply' do
      let(:change_to_return) { 148 }
      let(:change_supply) { { '1p': 6, '2p': 1, '10p': 3, '20p': 1, '50p': 3 } }

      it 'returns the greatest amount of highest value coins that it can without exceeding the amount owed' do
        expect(subject.call(change_to_return, change_supply)).to eq({ '50p': 2, '20p': 1, '10p': 2, '2p': 1, '1p': 6 })
      end
    end

    context 'when the change supply is not sufficient to cover the change owed' do
      let(:change_to_return) { 100 }
      let(:change_supply) { { '1p': 6, '2p': 1, '10p': 3, '20p': 1 } }

      it 'returns nil' do
        expect(subject.call(change_to_return, change_supply)).to eq(nil)
      end
    end

    context 'when the change supply contains a coin that is too large in value to be given at all' do
      let(:change_to_return) { 50 }
      let(:change_supply) { { '10p': 3, '20p': 1, '£1': 5 } }

      it 'does not include £1: 0 in the return object' do
        expect(subject.call(change_to_return, change_supply)).to eq({ '20p': 1, '10p': 3 })
      end
    end

    context 'when the change supply contains a coin that has a quantity of 0' do
      let(:change_to_return) { 50 }
      let(:change_supply) { { '10p': 3, '20p': 1, '50p': 0 } }

      it 'does not include 50p: 0 in the return object' do
        expect(subject.call(change_to_return, change_supply)).to eq({ '20p': 1, '10p': 3 })
      end
    end
  end
end
