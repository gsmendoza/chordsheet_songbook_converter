require "yaml"

module ChordsheetSongbookConverter
  class Output
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def write(song)
      data = {
        "chords" => {},
        "lyrics" => []
      }

      song.stanzas.each do |stanza|
        data["chords"][stanza.name] = nil
        data["lyrics"] << {stanza.name => nil}
      end

      File.write(@path, data.to_yaml)
    end
  end
end
