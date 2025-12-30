require "spec_helper"
require "chordsheet_songbook_converter/chord_line"

RSpec.describe ChordsheetSongbookConverter::ChordLine do
  describe "#formatted_text" do
    it "returns the text wrapped in angle brackets" do
      chord_line = described_class.new("Aadd9/F#")
      expect(chord_line.formatted_text).to eq("<Aadd9/F#>")
    end
  end
end
