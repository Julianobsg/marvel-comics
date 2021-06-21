class ComicsController < ApplicationController
  def index
    @comics = Comics.marvel_comics(params[:query])
  end
end
