# frozen_string_literal: true

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_handler)
    @product_handler = product_handler
  end

  attr_reader :product_handler

  def request_product(product)
    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)
  end
end
