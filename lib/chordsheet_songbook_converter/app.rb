require_relative "output"
require_relative "input"

module ChordsheetSongbookConverter
  class App
    def initialize(input_path:, output_path:)
      @input_path = input_path
      @output_path = output_path
    end

    def call
      content = File.read(@input_path)
      output = Output.new(@output_path)
      song = Input.new(content).to_song

      output.write(song)

      output.path
    end
  end
end
