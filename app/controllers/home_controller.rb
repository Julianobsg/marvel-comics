class HomeController < ApplicationController
  def index
    @comics = Comics.marvel_comics
  end
end
