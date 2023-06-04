class ApplicationController < ActionController::Base
  before_action :set_cart_items_count
  include Pagy::Backend
  private

  def set_cart_items_count
    @cart_items_count = CartItem.count # Adjust this to fetch your cart items count logic
  end
end
