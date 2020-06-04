class Member::MembersController < ApplicationController
	def top
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
			redirect_to member_path(@member)
		else
		end
	end

	def quit
		@member = Member.find(params[:id])
	end

	def hide
	end

	private
    def member_params
    	params.require(:member).permit(:member_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :telephone, :postal_code, :address, :is_deleted)
    end
end