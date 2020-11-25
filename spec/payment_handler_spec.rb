# frozen_string_literal: true

require 'payment_handler'

RSpec.describe PaymentHandler do
  let(:subject) { described_class.new }

  describe '#value_of' do
    let(:payment) { { '1p': 1, '2p': 2, '50p': 5, '£1': 2 } }

    it 'returns the total value of the payment' do
      expect(subject.value_of(payment)).to eq(4.55)
    end
  end
end
