class Album < ApplicationRecord
  has_many :songs
  belongs_to :artist

  validates :title, presence: true

  scope :search, -> (text) do
    self.joins("INNER JOIN albums_fts ON albums_fts.docid = albums.id")
        .where('albums_fts.title MATCH ?', "*#{text}*")
  end

  def self.build_index
    connection.execute("INSERT INTO albums_fts(albums_fts) VALUES ('rebuild')")
  end
end
