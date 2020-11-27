# frozen_string_literal: true

require 'change_handler'

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

  describe '#calculate_change_from_payment' do
    let(:product_price) { 0.01 }
    let(:payment_value) { 0.02 }

    it 'returns the calculated change' do
      expect(subject.calculate_change_from_payment(product_price, payment_value)).to eq(0.01)
    end

    context 'when the change owed exceeds the change supply' do
      let(:product_price) { 1 }
      let(:payment_value) { 2 }

      it 'returns nil' do
        expect(subject.calculate_change_from_payment(product_price, payment_value)).to eq(nil)
      end
    end
  end
end
