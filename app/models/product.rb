class Product < ApplicationRecord

	before_action :authenticate_menber!
	#ログインしていないとログインページにリダイレクト

	belongs_to :genre
	has_many :cart_products, dependent: :destroy
	has_many :order_products

	attacment :image
	#destroy:　false　必要？

	validates :name, presence: true
	#商品名
	#presence: true は存在しているかどうか

    validates :price, presence: true
    #税抜き価格

    validates :is_valid, inclusion: { in: [true, false] }#合ってる？
    #販売ステータス
    #参考記事
    #https://qiita.com/h1kita/items/772b81a1cc066e67930e

end
