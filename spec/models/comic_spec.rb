require 'rails_helper'

RSpec.describe Comic, type: :model do
  it 'lists all marvel comics', vcr: true do
    all_comics = Comic.marvel_comics
    expect(all_comics.count).to be 5
    expect(all_comics[0].id).to be 12
    expect(all_comics[0].thumbnail.path).to eq 'http://i.annihil.us/u/prod/marvel/i/mg/8/04/58e69de9d1fed'
  end
end
