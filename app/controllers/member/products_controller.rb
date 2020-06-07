class Member::ProductsController < ApplicationController


	def index
        @products = Product.joins(:genre).where(genres: { is_valid: true })
        @genres = Genre.where(is_valid: true)
        @quantity = Product.count
        @products = Product.page(params[:page]).per(8)
    end

    def show
         @product = Product.find(params[:id])
         @cart_product = CartProduct.new
         @genres = Genre.all
    end
end
