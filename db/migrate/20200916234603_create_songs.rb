class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.integer :album_id
      t.integer :artist_id
      t.string :title, null: false
      t.integer :track_number
      t.string :genre
      t.integer :year
      t.integer :length
      t.integer :disc_number
      t.string :folder
      t.string :filename

      t.timestamps

      t.index :artist_id
      t.index :album_id
    end
  end
end
