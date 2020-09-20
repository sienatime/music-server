class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album, optional: true

  validates :title, presence: true

  def path
    "#{folder}/#{filename}"
  end

  scope :search, -> (text) do
    self.joins("INNER JOIN songs_fts ON songs_fts.docid = songs.id")
        .where('songs_fts.title MATCH ?', "*#{text}*")
  end

  def self.build_index
    connection.execute("INSERT INTO songs_fts(songs_fts) VALUES ('rebuild')")
  end
end
