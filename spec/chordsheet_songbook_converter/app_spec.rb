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
    end

    # context "when provided a complete song" do
    #   let(:input_content) { File.read("spec/fixtures/Jack O’Connell, Brian Dunphy & Darren Holden - Rocky Road to Dublin.txt") }

    #   it "matches the expected output" do
    #     call_app

    #     expect(File.read(output_path)).to eq(File.read("spec/fixtures/Jack O’Connell, Brian Dunphy & Darren Holden - Rocky Road to Dublin.csv"))
    #   end
  end
end
