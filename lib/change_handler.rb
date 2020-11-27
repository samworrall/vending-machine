# frozen_string_literal: true

# ChangeHandler responsible for holding the state of the change supply and calculating change after payment
class ChangeHandler
  def initialize(change_supply, value_calculator)
    @change_supply = change_supply
    @value_calculator = value_calculator
  end

  attr_reader :change_supply, :value_calculator

  def calculate_change_from_payment(product_price, payment_value)
    change_from_payment = payment_value - product_price

    change_supply_value = value_calculator.value_of(change_supply)

    (change_supply_value - change_from_payment).negative? ? nil : change_from_payment
  end
end