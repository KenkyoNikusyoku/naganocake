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



    def search
    	@genre = Genre.find_by(name: params[:genre_name])
    	@products = Product.where(genre_id: @genre.id).page(params[:page]).per(8)
    	@quantity = @products.count
    	# where 各モデルをid以外の条件で検索する場合
    	# 該当するデータ全てが返ってくる。

    	@genres = Genre.where(is_valid: true)
    	# 部分テンプレート呼び出し
    	render :index
    end
end
