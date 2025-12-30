require_relative "output"
require_relative "input"

module ChordsheetSongbookConverter
  class App
    def initialize(input_path:, output_path:)
      @input_path = input_path
      @output_path = output_path
    end

    def call
      # content = File.read(@input_path)
      output = Output.new(@output_path)

      # TODO: update this later. Don't touch for now.
      # Input.new(content).to_song.stanzas.each do |stanza|
      #   stanza.lines.each do |line|
      #     output.cards << line.to_card
      #   end
      # end

      output.write

      output.path
    end
  end
end
