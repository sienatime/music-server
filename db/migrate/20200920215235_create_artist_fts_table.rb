class CreateArtistFtsTable < ActiveRecord::Migration[6.0]
  def up
    execute("CREATE VIRTUAL TABLE `artists_fts`
      USING FTS4(
        `name`,
        content=`artists`
      )")

    execute("CREATE VIRTUAL TABLE `albums_fts`
      USING FTS4(
        `title`,
        content=`albums`
      )")

    execute("CREATE VIRTUAL TABLE `songs_fts`
      USING FTS4(
        `title`,
        content=`songs`
      )")
  end

  def down
    execute('DROP TABLE IF EXISTS artists_fts')
    execute('DROP TABLE IF EXISTS albums_fts')
    execute('DROP TABLE IF EXISTS songs_fts')
  end
end
