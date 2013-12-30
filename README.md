# WebBlocks

[![Build Status](https://travis-ci.org/WebBlocks/WebBlocks.png)](https://travis-ci.org/WebBlocks/WebBlocks) [![Dependency Status](https://gemnasium.com/WebBlocks/WebBlocks.png)](https://gemnasium.com/WebBlocks/WebBlocks) [![Code Climate](https://codeclimate.com/github/WebBlocks/WebBlocks.png)](https://codeclimate.com/github/WebBlocks/WebBlocks)

## Installation

Install Ruby dependencies:

```
bundle
```

Install Node.js dependencies:

```
npm install
```

## Configuration

### Defining Components

WebBlocks uses [Bower](http://bower.io) to manage blocks.

To use a block, it should be added the `dependencies` section of `bower.json`.

For example, to use the `WebBlocks-visibility` block, which resides in the Git repository [WebBlocks/block-visibility](`https://github.com/WebBlocks/block-visibility`), add it to `bower.json`:

```json
{
    "name": "WebBlocks",
    "version": "2.0.0",
    "dependencies": {
        "WebBlocks-visibility": "WebBlocks/block-visibility"
    }
}
```

Only blocks to explicitly included in `Blocksfile.rb` need to be added to `bower.json`. Blocks that these blocks depend on will be resolved automatically as part of Bower's component management process.

### Including Blocks

While `bower.json` defines which blocks should be downloaded, `Blocksfile.rb` defines the properties of how these blocks should be included.

For example, to build WebBlocks with the `WebBlocks-visibility` block, add it to `Blocksfile.rb`:

```ruby
require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  include 'WebBlocks-visibility'
end
```

`Blocksfile.rb` also supports including sub-blocks.

For example, to build WebBlocks with only the `hide` and `breakpoint` namespaces of `WebBlocks-visibility`:

```ruby
require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  include 'WebBlocks-visibility', 'hide'
  include 'WebBlocks-visibility', 'breakpoint'
end
```

Although less common, one may use any of the syntax available for the `Blockfile.rb` file of a module (see [REFERENCE.md](REFERENCE.md)). This means that one can define new blocks explicitly within `Blocksfile.rb`, as well as modify properties of existing blocks.

For example, suppose that a sub-module was marked as required by the module developer. It could be swapped to optional, to avoid including it, such as:

```ruby
require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  block 'existing-block' do
    block 'formerly-required-sub-block', :required => false
  end
  include 'existing-block'
end
```

Similarly, one might add a custom block:

```ruby
require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  block 'new-block'
end
```

## Command-Line Interface

WebBlocks includes several tools located in `bin`. They can be used for analyzing configurations and compiling sources.

All tools support the `help` command to print out a list of available commands and global options. Additionally, one may call `help [COMMAND]` to get detailed usage details and options for the command.

All tools support the following options:

* `--reload-bower` to fetch a fresh copy of Bower components rather than any already in `bower_components`. This option should be used whenever dependencies are modified in `bower.json`.
* `--reload-registry` to use a fresh copy of the registry rather than one in the cache. This option should be used if `node_modules/bower/bin/bower` is ever explicitly called.

### `bin/inspect`

This utility is used to inspect WebBlocks configuration.

##### Bower

To get a list of components to be registered based on `bower.json`:

```
bin/inspect bower_registry
```

##### Blocks

To get a list of blocks and files as defined by `Blockfile.rb`:

```
bin/inspect blocks
```

To include attributes set on blocks and files:

```
bin/inspect blocks --attributes
```

To filter within a route:

```
bin/inspect --route="WebBlocks-visibility"
```

Note that attributes here are raw as defined by the `Blocksfile.rb` file and the `Blockfile.rb` files of registered blocks; some files with `:required = false` attributes here may still be included during dependency resolution.

##### Dependencies

To get a list of dependencies per the configuration of `Blocksfile.rb` and the blocks themselves:

```
bin/inspect dependency_list
```

To get an list of files in the order that they will be compiled by WebBlocks:

```
bin/inspect dependency_order
```

Both commands support a type option for the file type.

For example, to see only `scss` files:

```
bin/inspect dependency_order --type=scss
```

## Testing

Tests may be performed through `rake`:

```
rake test
```