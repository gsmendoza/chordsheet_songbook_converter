require "spec_helper"
require "chordsheet_songbook_converter/input"

RSpec.describe ChordsheetSongbookConverter::Input do
  describe "#to_song" do
    let(:input_content) { "" }
    let(:input) { described_class.new(input_content) }
    let(:song) { input.to_song }

    context "when the input is an empty file" do
      let(:input_content) { "" }

      it "generates an empty song" do
        expect(song.stanzas).to be_empty
      end
    end

    context "when the input is a file has a line that is not a stanza" do
      let(:input_content) { "X" }

      it "generates an empty song" do
        expect(song.stanzas).to be_empty
      end
    end

    context "when the input is a file with a single empty stanza" do
      let(:input_content) do
        <<~STANZA
          &
          [Intro]
        STANZA
      end

      it "generates a song with that stanza" do
        expect(song.stanzas.size).to eq(1)
        expect(song.stanzas[0].name).to eq("[Intro]")
        expect(song.stanzas[0].cleaned_name).to eq("Intro")
        expect(song.stanzas[0].chord_lines).to be_empty
      end
    end

    context "when the input is a file with a single stanza with a single chord line" do
      let(:input_content) do
        <<~STANZA
          &
          [Intro]
          Aadd9/F#
        STANZA
      end

      it "generates a song with that chord line" do
        expect(song.stanzas.size).to eq(1)
        stanza = song.stanzas[0]
        expect(stanza.name).to eq("[Intro]")
        expect(stanza.chord_lines.size).to eq(1)
        expect(stanza.chord_lines[0].text).to eq("Aadd9/F#")
      end
    end

    context "when the input is a file with a single stanza with multiple chord lines" do
      let(:input_content) do
        <<~STANZA
          &
          [Intro]
          Aadd9/F# G6 Dsus2 Aadd9/F#
          G6
        STANZA
      end

      it "generates a song with those chord lines" do
        expect(song.stanzas.size).to eq(1)
        stanza = song.stanzas[0]
        expect(stanza.name).to eq("[Intro]")
        expect(stanza.chord_lines.size).to eq(2)
        expect(stanza.chord_lines.map(&:text)).to eq(["Aadd9/F# G6 Dsus2 Aadd9/F#", "G6"])
      end
    end

    context "when the input has multiple stanzas" do
      let(:input_content) do
        <<~STANZA
          [Intro]
          [Verse 1]
        STANZA
      end

      it "generates a song with those stanzas" do
        expect(song.stanzas.map(&:cleaned_name)).to eq(["Intro", "Verse 1"])
      end
    end

    context "when the input has a stanza with a chord line and a lyric line" do
      let(:input_content) do
        <<~STANZA
          [Verse 1]
             Aadd9/F#
          Pangarap ko'y
        STANZA
      end

      it "generates a song with both chord and lyric lines" do
        expect(song.stanzas.size).to eq(1)
        stanza = song.stanzas[0]
        expect(stanza.name).to eq("[Verse 1]")
        expect(stanza.chord_lines.map(&:text)).to eq(["Aadd9/F#"])
        expect(stanza.lyric_lines.map(&:text)).to eq(["Pangarap ko'y"])
      end
    end
  end
end
