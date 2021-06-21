require 'rails_helper'

RSpec.describe 'Comics requests spec', type: :request do
  it 'creates a favorite comics' do
    post '/comics/10/favorite', params: { thumbnail_path: 'url', thumbnail_extension: 'jpg' }
    expect(Comics.last).to have_attributes(marvel_id: 10, thumbnail_path: 'url', thumbnail_extension: 'jpg', favorite: true)
  end
end
