# frozen_string_literal: true

require 'vending_machine'
require 'product_handler'
require 'payment_handler'

RSpec.describe VendingMachine do
  let(:subject) { described_class.new(product_handler, payment_handler) }
  let(:product_handler) { ProductHandler.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 1, "quantity": quantity } } }
  let(:payment_handler) { PaymentHandler.new }
  let(:quantity) { 1 }
  let(:payment) { { '1p': 1, '2p': 2 } }

  describe '#request_product' do
    context 'the product is out of stock' do
      let(:quantity) { 0 }

      it 'asks the user to choose a different product' do
        expect(subject.request_product('sprite', payment)).to eq(
          'Product out of stock, please choose a different product.'
        )
      end
    end

    context 'supplying insufficient payment to buy a product' do
      it 'asks the user to supply sufficient payment' do
        expect(subject.request_product('sprite', payment)).to eq(
          'Insufficient payment provided.'
        )
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
