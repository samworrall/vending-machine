# frozen_string_literal: true

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_handler, payment_handler, change_supply)
    @product_handler = product_handler
    @payment_handler = payment_handler
    @change_supply = change_supply
  end

  attr_reader :product_handler, :payment_handler, :change_supply

  def request_product(product, payment)
    product_price = product_handler.price_of(product)
    payment_value = payment_handler.value_of(payment)

    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)
    return 'Insufficient payment provided.' unless payment_sufficient?(product_price, payment_value)

    change = calculate_change(product_price, payment_value)

    return 'Machine has insufficient change, please provide exact payment.' unless change
  end

  private

  def payment_sufficient?(product_price, payment_value)
    payment_value >= product_price
  end

  def calculate_change(product_price, payment_value)
    change_value = payment_value - product_price
    change_supply_value = payment_handler.value_of(change_supply)

    (change_supply_value - change_value).negative? ? nil : change_value
  end
end
