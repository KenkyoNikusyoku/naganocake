class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    #show,edit,updateの内容重複の為
    before_action :set_product, only: [:show, :edit, :update]
    #before_action :set_genre, only: [:edit, :update, :new, :index, :create,]


    def index
        @products = Product.all
        #Products.paginate(page:params[:page])
    end

    def edit
    end

    def update
        @product.update(product_params)
        redirect_to admin_products_path
    end

    def show
    end

    def new
        @product = Product.new
      end
    
      def create
        @product = Product.new(product_params)
        @product.save
        redirect_to admin_products_path
        
      end

    private

    def product_params
        params.require(:product).permit(:name, :introduction, :price)
    end
    
    def set_product
        @product = Product.find(params[:id])
    end

    #ジャンルの表記どうする？

end
