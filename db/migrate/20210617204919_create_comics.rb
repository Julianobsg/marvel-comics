class CreateComics < ActiveRecord::Migration[6.0]
  def change
    create_table :comics do |t|
      t.integer :marvel_id
      t.boolean :favorite, default: false
      t.string :thumbnail_extension
      t.string :thumbnail_path
      t.timestamps
    end
  end
end
