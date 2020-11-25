# frozen_string_literal: true

require 'vending_machine'
require 'product_handler'

RSpec.describe VendingMachine do
  let(:subject) { described_class.new(product_handler) }
  let(:product_handler) { ProductHandler.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 1, "quantity": quantity } } }

  describe '#request_product' do
    context 'the product is out of stock' do
      let(:quantity) { 0 }

      it 'asks the user to choose a different product' do
        expect(subject.request_product('sprite')).to eq(
          'Product out of stock, please choose a different product.'
        )
      end
    end

    xcontext 'supplying insufficient money to buy a product' do
      xit 'asks the user to supply sufficient money' do
      end
    end

    xcontext 'the machine does not have the correct change in supply' do
      xit 'asks the user to supply exact change' do
      end
    end

    xcontext 'the product is in supply, the money supplied is sufficient, and the machine is able to supply change' do
      xit 'returns the requested product and updates internal supplies' do
      end
    end
  end

  describe '#load_product' do
    xit 'confirms the loading of product' do
    end
  end

  describe '#load_change' do
    xit 'confirms the loading of change' do
    end
  end
end
