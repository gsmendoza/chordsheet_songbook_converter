module ChordsheetSongbookConverter
  class ChordLine
    attr_reader :text

    def initialize(text)
      @text = text.strip
    end

    def formatted_text
      @text.split.map { |chord| "<#{chord}>" }.join(" ")
    end

    def to_s
      @text
    end
  end
end
