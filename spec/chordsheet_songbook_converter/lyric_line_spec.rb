require "spec_helper"
require "chordsheet_songbook_converter/lyric_line"

RSpec.describe ChordsheetSongbookConverter::LyricLine do
  describe "#formatted_text" do
    let(:lyric_line) { described_class.new(text) }

    context "when the line has consecutive spaces" do
      let(:text) { "   Now you're    here and you don't know why  " }

      it "trims the spaces" do
        expect(lyric_line.formatted_text).to eq("Now you're here and you don't know why")
      end
    end
  end
end
