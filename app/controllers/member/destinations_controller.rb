class Member::DestinationsController < ApplicationController
	before_action :authenticate_member!
	def index
		@new_destination = Destination.new
		@destinations = Destination.where(member_id: current_member.id)
	end

	def create
		@new_destination = Destination.new(destination_params)
		@new_destination.member_id = current_member.id
		if @new_destination.save
			redirect_to destinations_path, notice: "配送先の新規登録が完了しました。"
		else
			@destinations = Destination.all
			render :index
		end
	end

	def edit
		@destination = Destination.find(params[:id])
	end

	def update
		@destination = Destination.find(params[:id])
	    if @destination.update(destination_params)
	      redirect_to destinations_path, notice: "配送先の更新が完了しました。"
	    else
	      render :edit
	    end
	end

	def destroy
		destination = Destination.find(params[:id])
		destination.destroy
		redirect_to destinations_path, notice: "配送先の削除が完了しました。"
	end

	private
	def destination_params
		params.require(:destination).permit(:postal_code, :address, :receiver)
	end
end