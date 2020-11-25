# frozen_string_literal: true

require 'vending_machine'
require 'product_handler'
require 'value_calculator'
require 'change_handler'

RSpec.describe VendingMachine do
  let(:subject) { described_class.new(product_handler, value_calculator, change_handler) }
  let(:product_handler) { ProductHandler.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 1, "quantity": quantity } } }
  let(:value_calculator) { ValueCalculator.new }
  let(:change_handler) { ChangeHandler.new(change_supply, value_calculator) }
  let(:change_supply) { { '1p': 50, '5p': 5 } }
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

    context 'the machine does not have the correct change in supply' do
      let(:payment) { { '£2': 1 } }

      it 'asks the user to supply exact change' do
        expect(subject.request_product('sprite', payment)).to eq(
          'Machine has insufficient change, please provide exact payment.'
        )
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
