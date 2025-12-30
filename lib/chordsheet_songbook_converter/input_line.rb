module ChordsheetSongbookConverter
  class InputLine
    attr_reader :text

    def initialize(text:)
      @text = text.strip
    end

    def stanza_header?
      @text.start_with?("[") && @text.end_with?("]")
    end

    def chord_line?
      return false if @text.empty?

      @text.split.all? do |word|
        word =~ %r{\A[A-G](#|b)?([a-zA-Z0-9])*(/[A-G](#|b)?)?\z}
      end
    end

    def lyric_line?
      !@text.empty? && !stanza_header? && !chord_line?
    end
  end
end
