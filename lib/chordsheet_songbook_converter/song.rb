require "yaml"

module ChordsheetSongbookConverter
  class Song
    attr_accessor :stanzas

    def initialize
      @stanzas = []
    end

    def to_songbook
      data = {"chords" => {}, "lyrics" => []}

      stanzas.each do |stanza|
        data["chords"][stanza.cleaned_name] =
          stanza.chord_lines.map { |l| l.formatted_text }.join("\n")

        data["lyrics"] <<
          {stanza.cleaned_name => stanza.lyric_lines.map(&:text).join("\n")}
      end

      data
    end
  end
end
