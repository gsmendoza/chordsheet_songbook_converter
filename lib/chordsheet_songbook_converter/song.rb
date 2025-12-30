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
        if stanza.lines.any?
          content = stanza.lines.map { |l| "<#{l}>" }.join
        end

        data["chords"][stanza.name] = content
        data["lyrics"] << {stanza.name => nil}
      end
      data.to_yaml
    end
  end
end
