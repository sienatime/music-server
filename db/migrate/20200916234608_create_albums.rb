class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string :title, null: false

      t.timestamps

      t.index :artist_id
    end
  end
end
