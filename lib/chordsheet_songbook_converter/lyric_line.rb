module ChordsheetSongbookConverter
  class LyricLine
    attr_reader :text

    def initialize(text)
      @text = text.strip
    end
  end
end
