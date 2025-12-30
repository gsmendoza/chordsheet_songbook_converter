# ChordsheetSongbookConverter

`chordsheet_songbook_converter` is a Ruby gem designed to convert text-based chord sheets into a structured YAML songbook format. It parses raw text input, identifying stanzas, chord lines, and lyrics, and outputs a YAML representation suitable for use in songbook applications.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add chordsheet_songbook_converter
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install chordsheet_songbook_converter
```

## Usage

### Command Line

You can use the `chordsheet-songbook-converter` command to convert a text-based chord sheet to YAML:

```bash
chordsheet-songbook-converter path/to/song.txt [path/to/output.yml]
```

If the output path is not provided, it will default to the same filename with a `.yml` extension.

### Library

You can also use it within your Ruby code:

```ruby
require 'chordsheet_songbook_converter'

ChordsheetSongbookConverter::App.new(
  input_path: 'path/to/song.txt',
  output_path: 'path/to/output.yml'
).call
```

### Input Format

The input should be a text file where stanzas are identified by headers in brackets (e.g., `[Verse 1]`, `[Chorus]`). Chords should be placed on their own lines above the corresponding lyrics.

### Output Format

The output is a YAML file with the following structure:

```yaml
chords:
  Verse 1: |-
    <A> <B>
    <C>
lyrics:
- Verse 1: |-
    Lyric line 1
    Lyric line 2
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gsmendoza/chordsheet_songbook_converter.
