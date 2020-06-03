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
	end

	def hide
	end





	#private

    #def user_params
      #params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #end
end