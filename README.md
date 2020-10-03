# Music Server

This Rails app is designed to let you download your own music files over your local network. It does not contain any music files. It it designed to be run from the same machine containing your MP3 library. It is not intended to be deployed to the public Internet.

## Setup

### Run the app

Install Ruby 2.7.0 and bundler. If you need help with this, check out (Rails Girls)[http://railsgirls.com/files/vienna/install.html].

Pull or fork the repository.

Run `bundle install`.

Run your Rails server in a way that is accessible from the local network (may vary depending on your network/firewall settings. Try `rails server -p 80` or `rails server -b 0.0.0.0` if the regular ol' `rails server` doesn't work for you).

### Import your collection

Once the app is running, navigate to home. Choose your music directory path _relative_ to the Rails root (e.g. if your Rails app is in `~/users/me/workspace/music-server` and your music is in `~/users/me/Documents/Music`, provide the path `../../Documents/Music`). Do not use `~` as it will not work.

Wait for your collection to be imported. This may take a while. Stats will be shown when it is complete. The collection will be indexed for searching after the import is finished.

Access the server from another device on your network using the local IP address of the machine with the Rails server. You can find your network IP in your computer settings.
