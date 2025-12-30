module ChordsheetSongbookConverter
  class Stanza
    attr_reader :name, :lines

    def initialize(name)
      @name = name
      @lines = []
    end
  end
end
