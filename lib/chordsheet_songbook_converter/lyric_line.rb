module ChordsheetSongbookConverter
  class LyricLine
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def formatted_text
      text.squeeze(" ").strip
    end
  end
end
