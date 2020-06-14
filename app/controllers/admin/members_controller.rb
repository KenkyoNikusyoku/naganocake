class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.where(created_at: Time.zone.now.all_day)
  end

  def index
    @members = Member.all.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path(@member.id)
    else
      render action: :edit
    end
  end

  private
  def member_params
    params.require(:member).permit(:member_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :telephone, :postal_code, :address, :is_deleted )
  end
end
