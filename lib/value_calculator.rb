# frozen_string_literal: true

# ValueCalculator responsible for calculating the value of a supply of coins
class ValueCalculator
  COIN_TO_FLOAT = {
    '1p': 0.01, '2p': 0.02, '5p': 0.05, '10p': 0.1, '20p': 0.2, '50p': 0.5, '£1': 1.0, '£2': 2.0
  }.freeze

  def value_of(coins)
    total = 0
    coins.each { |coin, quantity| total += COIN_TO_FLOAT[coin] * quantity }
    total
  end
end
