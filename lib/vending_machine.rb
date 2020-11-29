# frozen_string_literal: true

require_relative './services/total_coin_value_calculator'
require_relative './services/change_calculator'
require_relative './product_handler'
require_relative './change_handler'

# VendingMachine class responsible for processing product requests and loading requests.
class VendingMachine
  def initialize(product_handler, change_handler)
    @product_handler = product_handler
    @change_handler = change_handler
  end

  attr_reader :product_handler, :change_handler

  def purchase_product(product, payment)
    return 'Product out of stock, please choose a different product.' unless product_handler.product_in_supply?(product)

    product_price = product_handler.price_of(product)
    payment_value = TotalCoinValueCalculator.value_of(payment)

    return 'Insufficient payment provided.' unless payment_sufficient?(product_price, payment_value)

    change_handler.add_change(payment)
    change = calculate_change(payment_value, product_price)

    if change.nil?
      dispense_change(payment)
      return 'Machine has insufficient change, please provide exact payment.'
    end

    dispense_product(product)
    dispense_change(change) unless change == 0

    { 'product': product, 'change': change }
  end

  def load_product(products)
    product_handler.add_product(products)
  end

  def load_change(change)
    change_handler.add_change(change)
  end

  private

  def payment_sufficient?(product_price, payment_value)
    payment_value >= product_price
  end

  def dispense_product(product)
    product_handler.remove_product(product)
  end

  def dispense_change(change)
    change_handler.remove_change(change)
  end

  def calculate_change(payment_value, product_price)
    change_owed = payment_value - product_price
    change_owed.zero? ? 0 : ChangeCalculator.call(change_owed, change_handler.change_supply)
  end
end
