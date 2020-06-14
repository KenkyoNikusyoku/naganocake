class Member::OrdersController < ApplicationController
  before_action :authenticate_member!

  include ApplicationHelper

  def new
    @order = Order.new
  end

  def create
    if @order = Order.create(params_int(order_params))
      @cart_products = CartProduct.where(member_id: current_member.id)
        @cart_products.each do |cart_product|
          @order_products = OrderProduct.create(
            product_id: cart_product.product.id,
            order_id: @order.id,
            price: cart_product.product.price,
            quantity: cart_product.quantity
            )
        end
      @cart_products.destroy_all
      case params[:order][:radio_number].to_i
      when 1 #自分の住所
      when 2#登録された住所から選択
      when 3#新規作成の住所
        #新規住所登録
        @destination = Destination.create(
          member_id: current_member.id,
          receiver: params[:order][:receiver],
          postal_code: params[:order][:postal_code],
          address: params[:order][:address]
          )
      end
      redirect_to thanks_orders_path
    else
      render :confirm, notice: '購入に失敗しました'
    end
  end

  def confirm
      @cart_products = CartProduct.where(member_id: current_member.id)
      @postage = 800
      @tax = 1.1
    if params[:order][:payment_option].nil?
      params[:order][:payment_option] =
        case params[:order][:radio_number].to_i
        when 1 ##自分の住所
          destination_when1
        when 2 ##登録された住所から選択
          destination_when2
        when 3
          destination_when3
        when 0 ##お届け選択無し
          destination_when0
        end
      @order.valid?
      render action: :new, notice: '支払い方法が選択されていません'
    else
      case params[:order][:radio_number].to_i
      when 1 ##自分の住所
        destination_when1
        @order.payment_option = params[:order][:payment_option].to_i
      when 2 ##登録された住所から選択
        destination_when2
        @order.payment_option = params[:order][:payment_option].to_i
      when 3
        destination_when3
        @order.payment_option = params[:order][:payment_option].to_i
      when 0 ##お届け選択無し
        destination_when0
      end

      if @order.valid?
      else
      render action: :new, notice: '配送先が選択されていません'
      end
    end
  end

  def thanks
  end

  def index
    @orders = Order.where(member_id: current_member.id).order(created_at: "DESC").page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  private

  def destination_when1
    ##自分の住所
    @order = Order.new(
    member_id: current_member.id,
    receiver: current_member.last_name + current_member.first_name,
    postal_code: current_member.postal_code,
    address: current_member.address,
    billing: @cart_products.map{ |cp| (cp.product.price*cp.quantity * @tax) }.sum.round + @postage
    )
  end

  def destination_when2
    ##登録された住所から選択
    destination = Destination.find(params[:order][:destination_id])
    @order = Order.new(
      member_id: current_member.id,
      receiver: destination.receiver,
      postal_code: destination.postal_code,
      address: destination.address,
      billing: @cart_products.map{ |cp| (cp.product.price*cp.quantity * @tax) }.sum.round + @postage
    )
  end

  def destination_when3
    ##新規作成の住所
    @order = Order.new(
      member_id: current_member.id,
      receiver: params[:order][:receiver],
      postal_code: params[:order][:postal_code],
      address: params[:order][:address],
      radio_number: params[:order][:radio_number].to_i,
      billing: @cart_products.map{ |cp| (cp.product.price*cp.quantity * @tax) }.sum.round + @postage
      )
  end

  def destination_when0
    @order = Order.new(
      member_id: current_member.id,
      billing: @cart_products.map{ |cp| (cp.product.price*cp.quantity * @tax) }.sum.round + @postage
      )
  end


  def order_params
    params.require(:order).permit(:member_id, :receiver, :postal_code, :address,
    :payment_option, :postage, :billing, :destination_id, :radio_number)
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
