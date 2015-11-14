class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :edit, :update, :destroy]

	def index 
		@movies = Movie.all

		query = params[:q]

    	@movies = Movie.where("title LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
	end 

	def create
		@movie = Movie.new movie_params

		if @movie.save
			flash[:notice] = "Movie has been created"
			redirect_to @movie
		else
			flash.now[:alert] = "Movie has not been created."
			render "new"
		end 
	end 

	def new 
		@movie = Movie.new
	end 

	def edit
	end 

	def show 

	end 

	def update
		if @movie.update(movie_params)
			flash[:notice] = "Movie has been updated."
			redirect_to @movie
		else
			flash.now[:alert] = "Movie has not been updated."
			render "edit"
		end 
	end 

	def destroy 
		@movie.destroy

		flash[:notice] = "Movie has been deleted."
		redirect_to movies_path
	end 

	private 

	def set_movie
		begin 
			@movie = Movie.find(params[:id])
		rescue 
			flash[:alert] = "The movie you are looking for could not be found."
			redirect_to movies_path
		end 
	end 

	def movie_params
		params.require(:movie).permit :title, :description, :year_released
	end 
end
