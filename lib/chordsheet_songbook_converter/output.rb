module ChordsheetSongbookConverter
  class Output
    attr_reader :path, :cards

    def initialize(path)
      @path = path
      @cards = []
    end

    def write
      File.write(@path, "")
    end
  end
end
