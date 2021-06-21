class Comics < ApplicationRecord
  def self.marvel_comics(character_names)
    marvel.comics({ orderBy: 'focDate', characters: characters(character_names) }.reject { |_, v| v.to_s.empty? })
  end

  def self.characters(character_names)
    return unless character_names

    character_names.split(',').map do |name|
      marvel.characters(nameStartsWith: name.strip).pluck(:id)
    end.reject { |c| c.empty? }.join(',')
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
