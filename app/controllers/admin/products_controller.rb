class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    #show,edit,updateの内容重複の為
    before_action :set_product, only: [:show, :edit, :update]


    def index
        @products = Products.paginate(page:params[:page])
    end

    def edit
    end

    def update
        @product.update(product_params)
        redirect_to 
    end

    def show
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        @product.save
        redirect_to 
    end

    private

    def product_params
        params.require(:product).permit(:name, :introduction, :image, :price, :is_valid)
    end

    def set_product
        @product = Product.find(params[:id])
    end


end
