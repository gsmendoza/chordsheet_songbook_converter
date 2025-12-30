module ChordsheetSongbookConverter
  class Line
    def initialize(input:, text:)
      @input = input
      @text = text.strip
    end

    def stanza_header?
      @text.start_with?("[") && @text.end_with?("]")
    end

    def cleaned_text
      if stanza_header?
        @text[1..-2]
      else
        @text
      end
    end

    def before_first_stanza?
      return false if stanza_header?
      !@input.seen_stanza_header?
    end
  end
end
