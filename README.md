# CellularAutomata

This is yet another cellular automata implementation.  Public API is liable to
break until 0.2.0.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cellular_automata'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cellular_automata

## Usage

```
cell_gui [options] RULE
    -w, --width WIDTH                Set width
    -h, --height HEIGHT              Set height
    -s, --scale SCALE                Factor by which to scale game board
    -c, --cell-width WIDTH           Factor by which to scale cells
                                     Use 1 for an 'LED' look
                                     Use 2 for no borders around cells
                                     or choose anything in between
    -f, --full-screen                Full screen
    -v, --version                    Print version information
        --help                       Display this screen
```

RULE is a [standard Life Rule](http://www.conwaylife.com/wiki/Cellular_automaton) in the format `S.../B...`  The `/` is optional, and it doesn't matter which comes first.

`cell` (a console version with simple ASCII output) also exists, but isn't near as interesting!

## Development

Install gosu dependencies:
```bash
% brew install sdl2 libogg libvorbis
```

## Contributing

1. Fork it ( https://github.com/ffleming/cellular_automata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
