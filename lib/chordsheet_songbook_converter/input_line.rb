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

    def chord_line?
      return false if @text.empty?

      @text.split.all? do |word|
        word =~ %r{\A[A-G](#|b)?([a-zA-Z0-9])*(/[A-G](#|b)?)?\z}
      end
    end
  end
end
