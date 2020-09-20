module Search
  class Indexer
    def self.index
      Artist.build_index
      Album.build_index
      Song.build_index
    end
  end
end
