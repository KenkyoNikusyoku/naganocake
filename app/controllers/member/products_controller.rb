class Member::ProductsController < ApplicationController


	def index
        @products = Product.all
        @genres = Genre.all
    end

    def show
         @product = Product.find(params[:id])
         @cart_product = CartProduct.new
         @genres = Genre.all
    end
end
