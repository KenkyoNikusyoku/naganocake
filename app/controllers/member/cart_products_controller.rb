class Member::CartProductsController < ApplicationController

	before_action :authenticate_menber!
    #ログインしていないとログインページにリダイレクト

    def index#カート内商品画面表示
        @cart_products = CartProduct.where(menber_id: current_menber.id)
        #where 複数
    end

    def update#カート内商品更新
        @cart_product = CartProduct.find(params[:id])

        if @cart_product.update(@cart_product_params)
        	redirect_to cart_product_path
        #条件を満たす場合
    end

    def create#カート商品保存・追加
        @cart_product = CartProduct.new(cart_products_params)#合ってる？

        if @cart_product.save
        #条件を満たす場合
            redirect_to cart_products_path
            #redirect_to request.referer
            #redirect_back(fallback_location: root_path)
            #redirect_back fallback_location: @cart_product

        else
        #条件を満たさない場合
            render action: :index#(仮)
        end

    end

    def destroy#カート内商品一つだけ削除
        @cart_product = CartProduct.find(params[:id])

    end

    def all_destroy#カート内商品全て削除
        @cart_products = CartProduct.all
        if @curt_product.menber == current_menber.id
           @curt_product.destroy_all
        end
    end

    private

    def cart_product_params
    	params.require(:cart_product).parmit(:menber_id :product_id)
end

#バリューて何？

#params フォームなどによって送られてきた情報（パラメーター）を取得する

#require 情報(パラメーター)の中にモデルに対応するキーが存在するかを確認し、
#存在する場合にそのバリューを返す


#permit 情報(パラメーター)をストロングパラメーターにする

#ストロングパラメーター permitメソッドによって保存するパラメーターの
#許可処理を行ったパラメーターのことをストロングパラメーターという





