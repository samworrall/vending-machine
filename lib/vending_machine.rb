# frozen_string_literal: true

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_handler, payment_handler)
    @product_handler = product_handler
    @payment_handler = payment_handler
  end

  attr_reader :product_handler, :payment_handler

  def request_product(product, payment)
    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)
    return 'Insufficient payment provided.' unless payment_sufficient?(product, payment)
  end

  private

  def payment_sufficient?(product, payment)
    payment_handler.value_of(payment) >= product_handler.price_of(product)
  end
end
