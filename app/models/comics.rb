class Comics < ApplicationRecord
  scope :favorites, -> { where(favorite: true) }

  def self.all_comics(character_names)
    favorites + marvel_comics(character_names, 20 - favorites.count).map { |m_comics| Comics.new(marvel_id: m_comics.id, thumbnail_path: m_comics.thumbnail.path, thumbnail_extension: m_comics.thumbnail.extension) }
  end

  def self.marvel_comics(character_names, limit=20)
    marvel.comics({ limit: limit, orderBy: 'focDate', characters: characters(character_names) }.reject { |_, v| v.to_s.empty? })
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

  def cover_image
    "#{thumbnail_path}/portrait_uncanny.#{thumbnail_extension}"
  end
end
