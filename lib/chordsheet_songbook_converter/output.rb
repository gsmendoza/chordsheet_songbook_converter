require "yaml"

module ChordsheetSongbookConverter
  class Output
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def write(song)
      File.write(@path, song.to_songbook.to_yaml)
    end
  end
end
