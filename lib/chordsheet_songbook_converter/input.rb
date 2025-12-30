require_relative "song"
require_relative "stanza"

module ChordsheetSongbookConverter
  class Input
    def initialize(content)
      @content = content
    end

    def to_song
      song = Song.new
      current_stanza = nil

      @content.each_line do |line|
        line = line.strip
        next if line.empty?
        next if line == "&"

        if line.start_with?("[") && line.end_with?("]")
          name = line[1..-2]
          current_stanza = Stanza.new(name)
          song.stanzas << current_stanza
        elsif current_stanza
          current_stanza.lines << line
        end
      end

      song
    end
  end
end
