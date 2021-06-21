class ComicsController < ApplicationController
  def index
    @comics = Comics.all_comics(params[:query])
  end

  def favorite
    comics = Comics.find_or_create_by(marvel_id: params[:comics_id])
    comics.update(comics_params.merge(favorite: !comics.favorite))
  end

  def comics_params
    params.require(:comics).permit(:thumbnail_path, :thumbnail_extension)
  end
end
