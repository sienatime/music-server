module Search
  class Query
    def self.go(term, per_page)
      sql =  ActiveRecord::Base.sanitize_sql(
        ["SELECT artists.id, 'artists' as TableName
        FROM artists
        INNER JOIN artists_fts ON artists_fts.docid = artists.id
        WHERE artists_fts.name MATCH ?
        UNION ALL
        SELECT albums.id, 'albums' as TableName
        FROM albums
        INNER JOIN albums_fts ON albums_fts.docid = albums.id
        WHERE albums_fts.title MATCH ?
        UNION ALL
        SELECT songs.id, 'songs' as TableName
        FROM songs
        INNER JOIN songs_fts ON songs_fts.docid = songs.id
        WHERE songs_fts.title MATCH ?
        LIMIT ?",
        "*#{term}*",
        "*#{term}*",
        "*#{term}*",
        per_page]
      )
      records_array = ActiveRecord::Base.connection.execute(sql)
    end
  end
end
