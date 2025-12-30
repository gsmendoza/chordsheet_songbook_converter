require "spec_helper"
require "chordsheet_songbook_converter/chord_line"

RSpec.describe ChordsheetSongbookConverter::ChordLine do
  describe "#formatted_text" do
    let(:text) { "Aadd9/F#" }
    let(:chord_line) { described_class.new(text) }

    it "returns the text wrapped in angle brackets" do
      expect(chord_line.formatted_text).to eq("<Aadd9/F#>")
    end

    context "when a chord is surround with spaces" do
      let(:text) { "   Aadd9/F#" }

      it "trims the spaces" do
        expect(chord_line.formatted_text).to eq("<Aadd9/F#>")
      end
    end

    context "when the text has multiple chords" do
      let(:text) { "Aadd9/F#                   G6           Dsus2" }

      it "formats them" do
        expect(chord_line.formatted_text).to eq("<Aadd9/F#> <G6> <Dsus2>")
      end
    end
  end
end
