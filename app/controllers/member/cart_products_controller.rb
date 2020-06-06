class Member::CartProductsController < ApplicationController
    before_action :authenticate_member!

    def index
        @cart_products = CartProduct.where(member_id: current_member.id)
    end

    def update
        @cart_products = CartProduct.find(params[:id])
        if @cart_products.update(cart_product_params)
          redirect_to cart_products_path,success: '個数を変更しました'
        else
          render :index, danger: "個数の変更に失敗しました。"
        end
    end

    def create
        @cart_product = CartProduct.new(cart_product_params)
        @cart_product.member_id = current_member.id
        if @cart_product.save
          redirect_to cart_products_path,success: '商品をカートに追加しました.'
        else
          @product = Product.find(@cart_product.product.id)
          render 'products/show'
        end
    end



    def destroy
        cart_product = CartProduct.find(params[:id])
        cart_product.destroy
        redirect_to cart_products_path,success: '商品の削除が完了しました。'
    end

    def all_destroy
        member = Member.find(current_member.id)
        if member.cart_products.destroy_all
          redirect_to cart_products_path,success: 'カート内の商品を全て削除しました。'
        else
          render :index, danger: "カート内の商品を削除出来ませんでした。"
        end
      end

    private

    def cart_product_params
        params.require(:cart_product).permit(:quantity, :price, :member_id, :product_id)
    end



end