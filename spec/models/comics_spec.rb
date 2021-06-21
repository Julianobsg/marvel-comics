require 'rails_helper'

RSpec.describe Comics, type: :model do
  describe '.marvel_comics', vcr: true do
    it 'lists all marvel comics' do
      all_comics = Comics.marvel_comics('')
      expect(all_comics.count).to be 5
      expect(all_comics[0].id).to be 12
      expect(all_comics[0].thumbnail.path).to eq 'http://i.annihil.us/u/prod/marvel/i/mg/8/04/58e69de9d1fed'
    end

    it 'does not lists duplicated comics' do
      Comics.create(marvel_id: 21, favorite: true)
      all_comics = Comics.all_comics('')
      expect(all_comics.pluck(:marvel_id).count).to be 20
      expect(all_comics.pluck(:marvel_id).group_by{ |e| e }[21].count).to be 1
    end

    it 'filters comics by character' do
      filtered_comics = Comics.marvel_comics('storm')
      expect(filtered_comics.count).to be 5
      expect(filtered_comics[0].id).to be 14371
      characters = filtered_comics[0].characters.items.map(&:name)
      expect(characters).to include 'Storm'
      expect(characters).to include 'X-Men'
    end

    it 'filters comics by multiple characters' do
      filtered_comics = Comics.marvel_comics('peter parker, wolverine')
      expect(filtered_comics.count).to be 5
      expect(filtered_comics[0].characters.items.map(&:name)).to include 'Wolverine'
      expect(filtered_comics[3].characters.items.map(&:name)).to include 'Peter Parker'
    end
  end

  describe '.characters', vcr: true do
    it 'returns empty if no character found' do
      characters = Comics.characters('non existent character')
      expect(characters).to eql ''
    end
  end
end
