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
        chord_content = nil
        if stanza.chord_lines.any?
          chord_content = stanza.chord_lines.map { |l| l.formatted_text }.join
        end

        lyric_content = nil
        if stanza.lyric_lines.any?
          lyric_content = stanza.lyric_lines.map(&:text).join("\n")
        end

        data["chords"][stanza.cleaned_name] = chord_content
        data["lyrics"] << {stanza.cleaned_name => lyric_content}
      end

      data
    end
  end
end
