require_relative "line"

module ChordsheetSongbookConverter
  class Input
    def initialize(content)
      @content = content
      @seen_stanza_header = false
    end

    def seen_stanza_header?
      @seen_stanza_header
    end

    def to_song
      song = {"chords" => {}, "lyrics" => []}

      @content.each_line do |line_text|
        line = Line.new(input: self, text: line_text)

        next if line.before_first_stanza?

        if line.stanza_header?
          @seen_stanza_header = true
          song["chords"][line.cleaned_text] = nil
          song["lyrics"] << {line.cleaned_text => nil}
        end
      end

      song
    end
  end
end
