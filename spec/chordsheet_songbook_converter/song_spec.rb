require "spec_helper"
require "chordsheet_songbook_converter/song"
require "chordsheet_songbook_converter/stanza"
require "chordsheet_songbook_converter/chord_line"

RSpec.describe ChordsheetSongbookConverter::Song do
  describe "#to_songbook" do
    let(:song) { described_class.new }
    let(:songbook) { song.to_songbook }

    context "when the song is empty" do
      it "generates an empty songbook" do
        expect(songbook).to eq({
          "chords" => {},
          "lyrics" => []
        })
      end
    end

    context "when the song has a single empty stanza" do
      before do
        song.stanzas << ChordsheetSongbookConverter::Stanza.new("[Intro]")
      end

      it "generates a songbook with that stanza" do
        expect(songbook["chords"]).to eq({"Intro" => nil})
        expect(songbook["lyrics"]).to eq([{"Intro" => nil}])
      end
    end

    context "when the song has a single stanza with a single chord line" do
      before do
        stanza = ChordsheetSongbookConverter::Stanza.new("[Intro]")
        stanza.chord_lines << ChordsheetSongbookConverter::ChordLine.new("Aadd9/F#")

        song.stanzas << stanza
      end

      it "generates a songbook with that chord line" do
        expect(songbook["chords"]).to eq({"Intro" => "<Aadd9/F#>"})
        expect(songbook["lyrics"]).to eq([{"Intro" => nil}])
      end
    end

    context "when the song has a single stanza with multiple chord lines" do
      before do
        stanza = ChordsheetSongbookConverter::Stanza.new("[Intro]")
        stanza.chord_lines << ChordsheetSongbookConverter::ChordLine.new("Aadd9/F# G6 Dsus2 Aadd9/F#")
        stanza.chord_lines << ChordsheetSongbookConverter::ChordLine.new("G6")

        song.stanzas << stanza
      end

      it "generates a songbook with those chord lines" do
        expected_content = "<Aadd9/F#> <G6> <Dsus2> <Aadd9/F#><G6>"

        expect(songbook["chords"]["Intro"]).to eq(expected_content)
      end
    end

    context "when the song has multiple stanzas" do
      before do
        song.stanzas << ChordsheetSongbookConverter::Stanza.new("[Intro]")
        song.stanzas << ChordsheetSongbookConverter::Stanza.new("[Verse 1]")
      end

      it "generates a songbook with those stanzas" do
        expect(songbook["chords"].keys).to eq(["Intro", "Verse 1"])
        expect(songbook["lyrics"]).to eq([{"Intro" => nil}, {"Verse 1" => nil}])
      end
    end

    context "when the song has a stanza with a chord line and a lyric line" do
      before do
        stanza = ChordsheetSongbookConverter::Stanza.new("[Verse 1]")
        stanza.chord_lines << ChordsheetSongbookConverter::ChordLine.new("Aadd9/F#")
        stanza.lyric_lines << ChordsheetSongbookConverter::LyricLine.new("Pangarap ko'y")

        song.stanzas << stanza
      end

      it "generates a song with both chord and lyric lines" do
        expect(songbook["chords"]["Verse 1"]).to eq("<Aadd9/F#>")
        expect(songbook["lyrics"]).to eq([{"Verse 1" => "Pangarap ko'y"}])
      end
    end
  end
end
