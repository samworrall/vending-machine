# frozen_string_literal: true

require 'product_handler'

RSpec.describe ProductHandler do
  let(:subject) { described_class.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 100, "quantity": quantity } } }
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

  describe '#price_of' do
    it 'returns the price of a product' do
      expect(subject.price_of('sprite')).to eq(100)
    end
  end

  describe '#dispense_product' do
    it 'reduces the quantity of the product by 1' do
      expect { subject.dispense_product('sprite') }.to change { subject.product_supply[:sprite][:quantity] }.by(-1)
    end
  end
end
