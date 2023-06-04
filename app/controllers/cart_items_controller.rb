class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @cart_item = current_user.cart_items.find_by(product: product)
  
    if @cart_item.present?
      @cart_item.increment!(:quantity)
      flash.now[:alert] = "Product quantity updated in the cart."
    else
      @cart_item = current_user.cart_items.build(product: product, quantity: 1, name: product.name, price: product.price, size: product.size, color: product.color)
      if @cart_item.save
        flash.now[:alert] = "Product added to cart successfully."
      else
        flash.now[:alert] = "Failed to add product to cart."
      end
    end
  
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      flash[:notice] = "Item removed from cart successfully."
    else
      flash[:alert] = "Failed to remove item from cart."
    end
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_user.cart_items
    @cart_items_count = @cart_items.count

  end
  def increment_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to cart_items_path
  end

  def decrement_quantity
    @cart_item = CartItem.find(params[:id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def checkout
    @cart_items = current_user.cart_items
    @cart_items_count = @cart_items.count
    @user_info = current_user.user_info || current_user.build_user_info
    @payment_info = current_user.payment_info || current_user.build_payment_info

  end
end
