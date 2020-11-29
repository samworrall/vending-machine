# frozen_string_literal: true

require 'services/total_coin_value_calculator'

RSpec.describe TotalCoinValueCalculator do
  let(:subject) { described_class }

  describe '#self.value_of' do
    let(:payment) { { '1p': 1, '2p': 2, '50p': 5, '£1': 2 } }

    it 'returns the total value of the payment' do
      expect(subject.value_of(payment)).to eq(455)
    end
  end
end
