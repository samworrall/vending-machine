# frozen_string_literal: true

# ProductHandler responsible for holding the state of the product supply
class ProductHandler
  def initialize(product_supply)
    @product_supply = product_supply
  end

  attr_reader :product_supply

  def product_in_supply?(product)
    product_supply[product.to_sym][:quantity].positive?
  end
end
