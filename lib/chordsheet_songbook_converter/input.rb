require_relative "input_line"
require_relative "chord_line"
require_relative "lyric_line"
require_relative "song"
require_relative "stanza"

module ChordsheetSongbookConverter
  class Input
    class MissingCurrentStanza < StandardError; end

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
        else
          raise MissingCurrentStanza if current_stanza.nil?

          if line.chord_line?
            current_stanza.chord_lines << ChordLine.new(line.text)
          elsif line.lyric_line?
            current_stanza.lyric_lines << LyricLine.new(line.text)
          end
        end
      end

      song
    end
  end
end
