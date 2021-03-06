# frozen_string_literal: true

require 'vending_machine'
require 'product_handler'
require 'change_handler'

RSpec.describe VendingMachine do
  let(:subject) { described_class.new(product_handler, change_handler) }
  let(:product_handler) { ProductHandler.new(product_supply) }
  let(:product_supply) { { "sprite": { "price": 100, "quantity": quantity } } }
  let(:change_handler) { ChangeHandler.new(change_supply) }
  let(:change_supply) { { '1p': 50, '5p': 5 } }
  let(:quantity) { 1 }
  let(:payment) { { '1p': 1, '2p': 2 } }

  describe '#purchase_product' do
    context 'the product is out of stock' do
      let(:quantity) { 0 }

      it 'asks the user to choose a different product' do
        expect(subject.purchase_product('sprite', payment)).to eq(
          'Product out of stock, please choose a different product.'
        )
      end
    end

    context 'supplying insufficient payment to buy a product' do
      it 'asks the user to supply sufficient payment' do
        expect(subject.purchase_product('sprite', payment)).to eq(
          'Insufficient payment provided.'
        )
      end
    end

    context 'the machine does not have the correct change in supply' do
      let(:payment) { { '£2': 1 } }

      it 'asks the user to supply exact change' do
        expect(subject.purchase_product('sprite', payment)).to eq(
          'Machine has insufficient change, please provide exact payment.'
        )
      end

      it 'does not keep the payment' do
        subject.purchase_product('sprite', payment)
        expect(subject.change_handler.change_supply[:£2]).to eq(0)
      end
    end

    context 'the product is in supply, the money supplied is sufficient, and the machine can supply change' do
      let(:payment) { { '50p': 1, '£2': 1 } }
      let(:change_supply) { { '£1': 2 } }

      it 'returns the purchased product / change and updates internal supplies' do
        expect(subject.purchase_product('sprite', payment)).to eq(
          {
            'product': 'sprite', 'change': { '£1': 1, '50p': 1 }
          }
        )
        expect(subject.product_handler.product_supply[:sprite][:quantity]).to eq(0)
        expect(subject.change_handler.change_supply[:'£1']).to eq(1)
      end
    end
  end

  describe '#load_product' do
    it 'updates internal product supplies' do
      subject.load_product(
        {
          "sprite": { "price": 100, "quantity": 5 },
          "oreos": { "price": 60, "quantity": 5 }
        }
      )
      expect(subject.product_handler.product_supply[:sprite][:quantity]).to eq(6)
      expect(subject.product_handler.product_supply[:oreos][:quantity]).to eq(5)
    end
  end

  describe '#load_change' do
    it 'updates internal change supplies' do
      subject.load_change({ '1p': 10, '£1': 10 })
      expect(subject.change_handler.change_supply[:'1p']).to eq(60)
      expect(subject.change_handler.change_supply[:'£1']).to eq(10)
    end
  end
end
