class Member::DestinationsController < ApplicationController
	def index
		@new_destination = Destination.new
		@destinations = Destination.all
	end

	def create
		@new_destination = Destination.new(destination_params)
		@new_destination.member_id = current_member.id
		if @new_destination.save
			redirect_to destinations_path
		else
			@destinations = Destination.all
			render :index
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def destination_params
		params.require(:destination).permit(:postal_code, :address, :receiver)
	end
end