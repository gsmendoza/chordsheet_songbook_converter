module ChordsheetSongbookConverter
  class InputLine
    attr_reader :text

    def initialize(input:, text:)
      @input = input
      @text = text.strip
    end

    def stanza_header?
      @text.start_with?("[") && @text.end_with?("]")
    end

    def before_first_stanza?
      return false if stanza_header?
      !@input.seen_stanza_header?
    end
  end
end
