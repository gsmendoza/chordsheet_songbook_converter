module ChordsheetSongbookConverter
  class Stanza
    attr_reader :name, :chord_lines, :lyric_lines

    def initialize(name)
      @name = name
      @chord_lines = []
      @lyric_lines = []
    end

    def cleaned_name
      @name[1..-2]
    end
  end
end
