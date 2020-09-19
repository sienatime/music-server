module Import
  class SongImportError
    attr_reader :error_messages, :path

    def initialize(error_messages, path)
      @error_messages = error_messages
      @path = path
    end
  end
end
