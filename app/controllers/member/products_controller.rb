class Member::ProductsController < ApplicationController


	def index
        @products = Product.joins(:genre).where(genres: { is_valid: true })
        @genres = Genre.where(is_valid: true)
        @quantity = Product.count
        # if
        #    @users = .page(params[:page]).per(8)
        # else

        # end
    end

    def show
         @product = Product.find(params[:id])
         @cart_product = CartProduct.new
         @genres = Genre.all
    end
end
