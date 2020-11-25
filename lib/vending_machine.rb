# frozen_string_literal: true

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_supply)
    @product_supply = product_supply
  end

  attr_reader :product_supply

  def request_product(product)
    product_quantity = product_supply[product.to_sym][:quantity]
    return 'This product is out of stock, please choose a different product.' unless product_quantity.positive?
  end
end
