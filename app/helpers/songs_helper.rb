module SongsHelper
  def format_song_length(length_in_seconds)
    minutes = length_in_seconds / 60
    seconds = length_in_seconds - (minutes * 60)
    seconds = "0#{seconds}" if seconds < 10

    "#{minutes}:#{seconds}"
  end
end
