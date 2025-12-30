require "spec_helper"
require "yaml"

RSpec.describe ChordsheetSongbookConverter::App do
  describe "#call" do
    let(:input_content) { "" }

    let(:input_path) { "tmp/input.txt" }
    let(:output_path) { "tmp/output.yml" }

    let(:call_app) { described_class.new(input_path:, output_path:).call }

    before do
      File.delete(input_path) if File.exist?(input_path)
      File.write(input_path, input_content)
    end

    describe "concerning existence of output path" do
      before do
        File.delete(output_path) if File.exist?(output_path)
      end

      context "when output path does not exist" do
        it "creates the file" do
          call_app

          expect(File.read(output_path)).to eq("---\nchords: {}\nlyrics: []\n")
        end
      end

      context "when output path exists" do
        before do
          File.write(output_path, "original text")
        end

        it "updates the file" do
          call_app

          expect(File.read(output_path)).to eq("---\nchords: {}\nlyrics: []\n")
        end
      end

      describe "concerning the input path" do
        context "when the input is an empty file" do
          let(:input_content) { "" }

          it "generates an empty songbook file" do
            call_app

            expect(File.read(output_path)).to eq("---\nchords: {}\nlyrics: []\n")
          end
        end

        context "when the input is a file has a line that is not a stanza" do
          let(:input_content) { "X" }

          it "generates an empty songbook file" do
            call_app

            expect(File.read(output_path)).to eq("---\nchords: {}\nlyrics: []\n")
          end
        end

        context "when the input is a file with a single empty stanza" do
          let(:input_content) do
            <<~STANZA
              &
              [Intro]
            STANZA
          end

          it "generates a songbook file with that stanza" do
            call_app

            songbook = YAML.load_file(output_path)

            expect(songbook["chords"].keys).to eq(["Intro"])
            expect(songbook["chords"]["Intro"]).to be_nil

            expect(songbook["lyrics"].size).to eq(1)
            expect(songbook["lyrics"][0]).to be_a(Hash)
            expect(songbook["lyrics"][0].keys).to eq(["Intro"])
            expect(songbook["lyrics"][0]["Intro"]).to be_nil
          end
        end

        #   context "when the input is a file has a single stanza with a single line" do
        #     let(:input_content) do
        #       <<~STANZA
        #         Sinners - Rocky Road to Dublin
        #         [Intro]
        #         ...         Then off to reap the corn,
        #       STANZA
        #     end

        #     it "generates an songbook file with a single card" do
        #       call_app

        #       expect(File.read(output_path)).to eq(%("Sinners - Rocky Road to Dublin\n0. First Line","1. [Intro]\n1. ...         Then off to reap the corn,"\n))
        #     end
        #   end
        # end

        # context "when provided a complete song" do
        #   let(:input_content) { File.read("spec/fixtures/Jack O’Connell, Brian Dunphy & Darren Holden - Rocky Road to Dublin.txt") }

        #   it "matches the expected output" do
        #     call_app

        #     expect(File.read(output_path)).to eq(File.read("spec/fixtures/Jack O’Connell, Brian Dunphy & Darren Holden - Rocky Road to Dublin.csv"))
        #   end
      end
    end
  end
end
