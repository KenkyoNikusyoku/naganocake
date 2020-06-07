class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.where(created_at: Time.zone.now.all_day)
  end

  def index
    @members = Member.all
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member.id)
  end

  private
  def member_params
    params.require(:member).permit(:member_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :telephone, :postal_code, :address, :is_deleted )
  end
end
