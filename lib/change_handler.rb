# frozen_string_literal: true

# ChangeHandler responsible for holding the state of the change supply and calculating change after payment
class ChangeHandler
  def initialize(change_supply)
    @change_supply = change_supply
  end

  attr_reader :change_supply

  def add_change(coins)
    coins.each do |coin, quantity|
      if change_supply[coin]
        change_supply[coin] += quantity
      else
        change_supply[coin] = quantity
      end
    end
  end

  def remove_change(coins)
    coins.each do |coin, quantity|
      change_supply[coin] -= quantity
    end
  end
end
