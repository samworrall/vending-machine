# frozen_string_literal: true

require 'value_calculator'
require 'change_calculator'

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_handler, change_handler)
    @product_handler = product_handler
    @change_handler = change_handler
  end

  attr_reader :product_handler, :change_handler

  def request_product(product, payment)
    product_price = product_handler.price_of(product)
    payment_value = ValueCalculator.value_of(payment)

    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)
    return 'Insufficient payment provided.' unless payment_sufficient?(product_price, payment_value)

    change_owed = payment_value - product_price
    change = change_owed.zero? ? 0 : ChangeCalculator.new.call(change_owed, change_handler.change_supply)

    return 'Machine has insufficient change, please provide exact payment.' unless change
  end

  private

  def payment_sufficient?(product_price, payment_value)
    payment_value >= product_price
  end
end
