require "spec_helper"
require "chordsheet_songbook_converter/song"
require "chordsheet_songbook_converter/stanza"
require "chordsheet_songbook_converter/chord_line"

RSpec.describe ChordsheetSongbookConverter::Song do
  describe "#to_songbook_yaml" do
    let(:song) { described_class.new }
    let(:yaml) { song.to_songbook_yaml }
    let(:parsed_yaml) { YAML.safe_load(yaml) }

    context "when the song is empty" do
      it "generates an empty songbook" do
        expect(parsed_yaml).to eq({
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
        expect(parsed_yaml["chords"]).to eq({"Intro" => nil})
        expect(parsed_yaml["lyrics"]).to eq([{"Intro" => nil}])
      end
    end

    context "when the song has a single stanza with a single chord line" do
      before do
        stanza = ChordsheetSongbookConverter::Stanza.new("[Intro]")
        stanza.chord_lines << ChordsheetSongbookConverter::ChordLine.new("Aadd9/F#")
        song.stanzas << stanza
      end

      it "generates a songbook with that chord line" do
        expect(parsed_yaml["chords"]).to eq({"Intro" => "<Aadd9/F#>"})
        expect(parsed_yaml["lyrics"]).to eq([{"Intro" => nil}])
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
        # Wait, how are they joined?
        # Song.rb: content = stanza.chord_lines.map { |l| l.formatted_text }.join
        # So no space between lines?
        # Let's check logic.

        # ChordLine 1: "<Aadd9/F#> <G6> <Dsus2> <Aadd9/F#>" (space separated chords)
        # ChordLine 2: "<G6>"
        # Joined: "<Aadd9/F#> <G6> <Dsus2> <Aadd9/F#><G6>"

        expect(parsed_yaml["chords"]["Intro"]).to eq(expected_content)
      end
    end

    context "when the song has multiple stanzas" do
      before do
        song.stanzas << ChordsheetSongbookConverter::Stanza.new("[Intro]")
        song.stanzas << ChordsheetSongbookConverter::Stanza.new("[Verse 1]")
      end

      it "generates a songbook with those stanzas" do
        expect(parsed_yaml["chords"].keys).to eq(["Intro", "Verse 1"])
        expect(parsed_yaml["lyrics"]).to eq([{"Intro" => nil}, {"Verse 1" => nil}])
      end
    end
  end
end
