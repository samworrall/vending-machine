# frozen_string_literal: true

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  COIN_TO_FLOAT = {
    '1p': 0.01, '2p': 0.02, '5p': 0.05, '10p': 0.1, '20p': 0.2, '50p': 0.5, '£1': 1.0, '£2': 2.0
  }.freeze

  def initialize(product_handler)
    @product_handler = product_handler
  end

  attr_reader :product_handler

  def request_product(product, payment)
    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)
    return 'Insufficient payment provided.' unless value_of(payment) >= product_handler.price_of(product)
  end

  private

  def value_of(payment)
    total = 0
    payment.each { |coin, quantity| total += COIN_TO_FLOAT[coin] * quantity }
    total
  end
end
