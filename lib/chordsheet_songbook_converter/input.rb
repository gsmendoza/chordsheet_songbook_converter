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
      stanza_names_count = Hash.new(0)

      @content.each_line do |line_text|
        line = InputLine.new(input: self, text: line_text)

        next if line.before_first_stanza?

        if line.stanza_header?
          @seen_stanza_header = true

          stanza_names_count[line.text] += 1

          current_stanza_name =
            if stanza_names_count[line.text] > 1
              line.text.sub("]", " #{stanza_names_count[line.text]}]")
            else
              line.text
            end

          current_stanza = Stanza.new(current_stanza_name)

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
