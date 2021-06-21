require 'rails_helper'

RSpec.describe 'Comics requests spec', type: :request do
  it 'renders marvel comics covers', vcr: true do
    get '/comics'
    expect(response).to render_template(:index)
    expect(response.body).to include '<img src="http://i.annihil.us/u/prod/marvel/i/mg/8/04/58e69de9d1fed/portrait_uncanny.jpg" />'
  end

  it 'creates a favorite comics' do
    post '/comics/10/favorite', params: { thumbnail_path: 'url', thumbnail_extension: 'jpg' }
    expect(Comics.last).to have_attributes(marvel_id: 10, thumbnail_path: 'url', thumbnail_extension: 'jpg', favorite: true)
  end
end
