class Admin::GenresController < ApplicationController
    before_action :authenticate_admin!
    #,edit,updateの内容重複の為
    before_action :set_genre, only: [:edit, :update]

    
    def index
        @genres = Genres.paginate(page:params[:page])
        @genre = Genre.new
    end

    def create
        @genre = Genre.new(genre_params)
        @genre.save
        redirect_to
    end

    def edit
    end

    def update
        @genre.update
        redirect_to
    end

    private

    def genre_params
        params.require(genre).permit(:name, :is_valid)
    end

    def set_genre
        @genre = Genre.find(params[:id])
    end

end
