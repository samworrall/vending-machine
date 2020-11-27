# frozen_string_literal: true

require_relative './services/lookup_table'

# ValueCalculator responsible for calculating the value of a supply of coins
class ValueCalculator
  def self.value_of(coins)
    total = 0
    coins.each { |coin, quantity| total += LookupTable::COIN_TO_VALUE[coin] * quantity }
    total
  end
end
