require_relative "line"
require_relative "song"
require_relative "stanza"

module ChordsheetSongbookConverter
  class Input
    def initialize(content)
      @content = content
      @seen_stanza_header = false
    end

    def seen_stanza_header?
      @seen_stanza_header
    end

    def to_song
      song = Song.new
      current_stanza = nil

      @content.each_line do |line_text|
        line = Line.new(input: self, text: line_text)

        next if line.before_first_stanza?

        if line.stanza_header?
          @seen_stanza_header = true
          current_stanza = Stanza.new(line.cleaned_text)
          song.stanzas << current_stanza
        elsif current_stanza
          current_stanza.lines << line.cleaned_text
        end
      end

      song
    end
  end
end
