require_relative "input_line"
require_relative "chord_line"
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
        line = InputLine.new(input: self, text: line_text)

        next if line.before_first_stanza?

        if line.stanza_header?
          @seen_stanza_header = true
          current_stanza = Stanza.new(line.text)
          song.stanzas << current_stanza
        elsif current_stanza
          current_stanza.chord_lines << ChordLine.new(line.text)
        end
      end

      song
    end
  end
end
