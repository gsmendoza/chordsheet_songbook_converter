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
        content = nil
        if stanza.chord_lines.any?
          content = stanza.chord_lines.map { |l| l.formatted_text }.join
        end

        data["chords"][stanza.cleaned_name] = content
        data["lyrics"] << {stanza.cleaned_name => nil}
      end

      data
    end
  end
end
