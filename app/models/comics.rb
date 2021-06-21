class Comics < ApplicationRecord
  def self.marvel_comics(character_names = nil)
    marvel.comics({ orderBy: 'focDate', characters: characters(character_names) }.compact)
  end

  def self.characters(character_names)
    return unless character_names

    marvel.characters(nameStartsWith: character_names).pluck(:id).join(',')
  end

  def self.marvel
    @marvel ||= config_marvel
  end

  def self.config_marvel
    marvel = Marvel::Client.new
    marvel.configure do |config|
      config.api_key = ENV['MARVEL_PUBLIC_KEY']
      config.private_key = ENV['MARVEL_PRIVATE_KEY']
    end
    marvel
  end
end
