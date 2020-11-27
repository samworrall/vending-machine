# frozen_string_literal: true

require_relative './services/lookup_table'

# ChangeCalculator responsible for calculating the correct coins to return as change
class ChangeCalculator
  def self.call(change_owed, change_supply)
    change_owed_in_coins = {}

    change_supply_coin_values(change_supply).each do |coin_value|
      coin = coin_to_value.key(coin_value)
      max_num_of_coin_to_return = change_owed / coin_value
      next if max_num_of_coin_to_return.zero?
      available_num_of_coin_to_return = change_supply[coin]

      num_of_coin_to_return = if available_num_of_coin_to_return < max_num_of_coin_to_return
                                available_num_of_coin_to_return
                              else
                                max_num_of_coin_to_return
                              end

      change_owed -= num_of_coin_to_return * coin_value
      change_owed_in_coins[coin] = num_of_coin_to_return
      break if change_owed.zero?
    end

    return nil if change_owed.positive?

    change_owed_in_coins
  end

  def self.change_supply_coin_values(change_supply)
    change_supply.map { |coin, _| coin_to_value[coin] }.sort.reverse
  end

  def self.coin_to_value
    LookupTable::COIN_TO_VALUE
  end

  private_class_method :change_supply_coin_values, :coin_to_value
end
