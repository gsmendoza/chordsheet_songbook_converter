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

      current_stanza_name = nil

      @content.each_line do |line_text|
        line = Line.new(input: self, text: line_text)

        next if line.before_first_stanza?

        if line.stanza_header?
          @seen_stanza_header = true
          current_stanza_name = line.cleaned_text
          song["chords"][current_stanza_name] = nil
          song["lyrics"] << {current_stanza_name => nil}
        elsif current_stanza_name
          current_val = song["chords"][current_stanza_name]
          new_val = "<#{line.cleaned_text}>"
          song["chords"][current_stanza_name] = current_val ? "#{current_val}#{new_val}" : new_val
        end
      end

      song
    end
  end
end
