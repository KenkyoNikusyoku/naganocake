class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  include ApplicationHelper

  def index
  	@orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def order_update
    @order = Order.find(params[:id])
    if @order.update( params_int(order_params) )
      @order.auto_update_work_status
      redirect_to "/admin/orders/#{@order.id}", success: "注文ステータスの更新が完了しました。"
    else
      @order_products = @order.order_products
      render action: :show, danger: "注文ステータスの更新に失敗しました。"
    end
  end

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find(@order_product.order.id)
    if @order_product.update( params_int(order_product_params) )
      @order_product.auto_update_order_status
      redirect_to "/admin/orders/#{@order.id}", success: "製作ステータスの更新が完了しました。"
    else
      @order_products = @order.order_products
      render action: :show, danger: "製作ステータスの更新に失敗しました。"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_product_params
    params.require(:order_product).permit(:work_status)
  end

  #数値に変換可能なparamsをintegerに変換してくれる
  def params_int(model_params)
    model_params.each do |key, value|
      #数値に変換可能かを確認(application_helper.rbに定義してあります。)
      if integer_string?(value)
        #数値に変換
        model_params[key]=value.to_i
      end
    end
  end
end
