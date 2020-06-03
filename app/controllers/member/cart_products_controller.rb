class Member::CartProductsController < ApplicationController

	before_action :authenticate_menber!
	#ログインしていないとログインページにリダイレクト

	def index#カート内商品画面表示
		#new?
	end

	def update#カート内商品更新
		@cart_product = CartProduct.find(params[:id])
	end

	def create#カート商品保存・追加
		@cart_product = CartProduct.new(cart_products_params)#合ってる？

		if @cart_product.save
		#条件を満たす場合
		    redirect_to cart_products_path

	    else
	    #条件を満たさない場合
	    end


	end

	def destroy#カート内商品一つだけ削除
		@cart_product = CartProduct.find(params[:id])

	end

	def all_destroy#カート内商品全て削除
		@cart_products = CartProduct.all
	end
end
