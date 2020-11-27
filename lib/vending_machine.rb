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

    change_handler.add_change(payment)
    change_owed = payment_value - product_price
    change = change_owed.zero? ? 0 : ChangeCalculator.call(change_owed, change_handler.change_supply)

    return 'Machine has insufficient change, please provide exact payment.' unless change

    product_handler.dispense_product(product)
    change_handler.dispense_change(change)

    { 'product': product, 'change': change }
  end

  def load_product(products)
    product_handler.load_product(products)
  end

  def load_change(change)
    change_handler.add_change(change)
  end

  private

  def payment_sufficient?(product_price, payment_value)
    payment_value >= product_price
  end
end
