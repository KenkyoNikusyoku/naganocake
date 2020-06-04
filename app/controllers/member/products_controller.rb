class Member::ProductsController < ApplicationController


	def index
        @products = Product.all
    end

    def show
         @product = Product.find(params[:id])
         @cart_product = CartProduct.new
    end
end
