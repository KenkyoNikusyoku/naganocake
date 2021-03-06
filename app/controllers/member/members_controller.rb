class Member::MembersController < ApplicationController
	before_action :authenticate_member!, except: :top

	def top
    	@products = Product.joins(:genre).where(genres: { is_valid: true }).shuffle.first(4)
    	@genres = Genre.where(is_valid: true)
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
			redirect_to member_path(@member), notice: "登録情報を更新しました。"
		else
			render :edit
		end
	end

	def quit
		@member = Member.find(params[:id])
	end

	def hide
		member = current_member
	    member.update(is_deleted: true)
	    #update後にログアウトしたい。
	    sign_out member
		redirect_to root_path, notice: "退会処理が完了しました。ご利用ありがとうございました。"
	    #リダイレクト先：トップページに変更する
	end

	private
    def member_params
    	params.require(:member).permit(:member_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :telephone, :postal_code, :address, :is_deleted)
    end
end