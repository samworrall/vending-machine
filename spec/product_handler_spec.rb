# frozen_string_literal: true

require 'product_handler'

RSpec.describe ProductHandler do
  let(:subject) { described_class.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 1, "quantity": quantity } } }
  let(:quantity) { 1 }

  describe '#product_supply' do
    it 'returns the product supply' do
      expect(subject.product_supply).to eq(product_supply)
    end
  end

  describe '#product_in_supply?' do
    context 'the product is in stock' do
      it 'returns true' do
        expect(subject.product_in_supply?('sprite')).to eq(true)
      end
    end

    context 'the product is not in stock' do
      let(:quantity) { 0 }

      it 'returns false' do
        expect(subject.product_in_supply?('sprite')).to eq(false)
      end
    end
  end
end
