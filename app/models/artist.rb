class Artist < ApplicationRecord
  has_many :albums
  has_many :songs

  validates :name, presence: true

  scope :search, -> (text) do
    self.joins("INNER JOIN artists_fts ON artists_fts.docid = artists.id")
        .where('artists_fts.name MATCH ?', "*#{text}*")
  end

  def self.build_index
    connection.execute("INSERT INTO artists_fts(artists_fts) VALUES ('rebuild')")
  end
end
