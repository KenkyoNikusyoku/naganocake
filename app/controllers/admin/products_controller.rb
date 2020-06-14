class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    #show,edit,updateの内容重複の為
    before_action :set_product, only: [:show, :edit, :update]
    before_action :set_genres, only: [:edit, :update, :new, :index, :create,]


    def index
        @products = Product.all.page(params[:page]).per(10)
        # Products.paginate(page:params[:page])
    end

    def edit
    end

    def update
        if @product.update(product_params)
            redirect_to admin_product_path(@product)
        else
            render 'edit'
        end
    end

    def show
    end

    def new
        @product = Product.new
      end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to admin_product_path(@product)
        else
            render 'new'
        end

    end

    private

    def product_params
        params.require(:product).permit(:name, :introduction, :price, :genre_id, :is_valid, :image)
    end

    def set_product
        @product = Product.find(params[:id])
    end

    #ジャンルの表記どうする？
    def set_genres
        @genres = Genre.where(is_valid: true)
    end

end
