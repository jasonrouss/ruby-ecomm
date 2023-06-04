class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update, :destroy, :new, :create]
  
    def index
      @pagy, @products = pagy(Product.all, items: 6)
      
      # Filter by price range
      if params[:min_price].present? && params[:max_price].present?
        @products = @products.where(price: params[:min_price]..params[:max_price])
      end
    
      # Filter by color
      if params[:color].present?
        @products = @products.where(color: params[:color])
      end
    
      # Filter by size
      if params[:size].present?
        @products = @products.where(size: params[:size])
      end
    
      # Filter by category
      if params[:category].present?
        @products = @products.where(category: params[:category])
      end
      
      # Filter by condition
      if params[:condition].present?
        @products = @products.where(condition: params[:condition])
      end
    
      # Search by product name (case-insensitive)
      if params[:search].present?
        @products = @products.where('lower(name) LIKE ?', "%#{params[:search].downcase}%")
      end
    end
    
    def filter
      redirect_to products_path(
        min_price: params[:min_price],
        max_price: params[:max_price],
        color: params[:color],
        size: params[:size],
        category: params[:category], 
        condition: params[:condition]

      )
    end
    
  
    def show
      @product = Product.find(params[:id])
    end
    
  
    def new
      @product = Product.new
    end
  
    def create
      @product = Product.new(product_params)
    
      if @product.save
        flash[:success] = 'Product was successfully created.'
        redirect_to @product
      else
        render :new
      end
    end
    
  
    def edit
    end
  
    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
    
    def destroy
      @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    end
    def by_category
      @category = params[:category]
      @products = Product.where(category: @category)
    end
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :price, :description, :image, :condition, :size, :color, :category)
    end
  end
  