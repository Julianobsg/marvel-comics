class HomeController < ApplicationController
  def index
    @comics = Comic.marvel_comics
  end
end
