class Comic < ApplicationRecord
  def self.marvel_comics
    marvel.comics(orderBy: 'focDate')
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
