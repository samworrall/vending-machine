# frozen_string_literal: true

# ChangeHandler responsible for holding the state of the change supply and calculating change after payment
class ChangeHandler
  def initialize(change_supply)
    @change_supply = change_supply
  end

  attr_reader :change_supply

  def calculate_change_from_payment(product_price, payment_value)
    change_from_payment = payment_value - product_price

    change_supply_value = ValueCalculator.value_of(change_supply)

    (change_supply_value - change_from_payment).negative? ? nil : change_from_payment
  end

  def add_change(coins)
    coins.each do |coin, quantity|
      if change_supply[coin]
        change_supply[coin] += quantity
      else
        change_supply[coin] = quantity
      end
    end
  end

  def dispense_change(coins)
    coins.each do |coin, quantity|
      change_supply[coin] -= quantity
    end
  end
end
