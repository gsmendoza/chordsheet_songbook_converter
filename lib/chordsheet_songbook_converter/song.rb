require "yaml"

module ChordsheetSongbookConverter
  class Song
    attr_accessor :stanzas

    def initialize
      @stanzas = []
    end

    def to_songbook_yaml
      data = {"chords" => {}, "lyrics" => []}
      stanzas.each do |stanza|
        content = nil
        if stanza.chord_lines.any?
          content = stanza.chord_lines.map { |l| l.formatted_text }.join
        end

        data["chords"][stanza.cleaned_name] = content
        data["lyrics"] << {stanza.cleaned_name => nil}
      end
      data.to_yaml
    end
  end
end
