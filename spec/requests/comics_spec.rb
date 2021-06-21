require 'rails_helper'

RSpec.describe 'Comics requests spec', type: :request do
  it 'renders marvel comics covers', vcr: true do
    Comics.create(marvel_id: 1, thumbnail_path: 'http://favorite/cover', thumbnail_extension: 'jpg')
    get '/comics'
    expect(response).to render_template(:index)
    expect(response.body).to_not include '<input type="image" name="commit" value="" src="http://favorite/cover/portrait_uncanny.jpg" data-disable-with="" />'
    expect(response.body).to include '<input type="image" name="commit" value="" src="http://i.annihil.us/u/prod/marvel/i/mg/8/04/58e69de9d1fed/portrait_uncanny.jpg" data-disable-with="" />'
    expect(response.body.scan(/comics-cover/).count).to be 20
  end

  it 'renders favorite marvel comics cover', vcr: true do
    Comics.create(marvel_id: 1, thumbnail_path: 'http://favorite/cover', thumbnail_extension: 'jpg', favorite: true)
    get '/comics'
    expect(response).to render_template(:index)
    expect(response.body).to include '<input type="image" name="commit" value="" src="http://favorite/cover/portrait_uncanny.jpg" data-disable-with="" />'
    expect(response.body.scan(/comics-cover/).count).to be 20
  end

  it 'creates a favorite comics' do
    post '/comics/10/favorite', params: { comics: { thumbnail_path: 'url', thumbnail_extension: 'jpg' } }
    expect(Comics.last).to have_attributes(marvel_id: 10, thumbnail_path: 'url', thumbnail_extension: 'jpg', favorite: true)
  end
end
