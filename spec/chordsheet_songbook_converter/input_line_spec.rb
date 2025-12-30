require "spec_helper"
require "chordsheet_songbook_converter/input_line"

RSpec.describe ChordsheetSongbookConverter::InputLine do
  describe "#chord_line?" do
    let(:input_line) { described_class.new(input: nil, text:) }
    subject { input_line.chord_line? }

    context "when all the words of the line look like chords" do
      let(:text) { "Aadd9/F# G6 Dsus2 Aadd9/F# A Am" }

      it { is_expected.to be_truthy }
    end

    context "when all the words of the line are minor chords" do
      let(:text) { "Am Bm" }

      it { is_expected.to be_truthy }
    end

    context "when any of the words of the line is not a chord" do
      let(:text) { "Am Not A chord line" }

      it { is_expected.to be_falsey }
    end
  end
end
