# frozen_string_literal: true

# ProductHandler responsible for holding the state of the product supply
class ProductHandler
  def initialize(product_supply)
    @product_supply = product_supply
  end

  attr_reader :product_supply

  def product_in_supply?(product)
    return false if product_supply[product.to_sym].nil?

    product_supply[product.to_sym][:quantity].positive?
  end

  def price_of(product)
    product_supply[product.to_sym][:price]
  end

  def remove_product(product)
    product_supply[product.to_sym][:quantity] -= 1
  end

  def add_product(products)
    products.each do |product, attributes|
      if product_supply[product]
        product_supply[product][:quantity] += attributes[:quantity]
      else
        product_supply[product] = attributes
      end
    end
  end
end
