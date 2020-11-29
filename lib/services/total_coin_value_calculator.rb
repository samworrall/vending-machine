# frozen_string_literal: true

require_relative '../coin_values'

# ValueCalculator responsible for calculating the value of a supply of coins
class TotalCoinValueCalculator
  def self.value_of(coins)
    total = 0
    coins.each { |coin, quantity| total += CoinValues::COIN_VALUES_IN_PENCE[coin] * quantity }
    total
  end
end
