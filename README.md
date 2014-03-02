# WebBlocks

[![Code Climate](https://codeclimate.com/github/WebBlocks/WebBlocks.png)](https://codeclimate.com/github/WebBlocks/WebBlocks) [![Build Status](https://travis-ci.org/WebBlocks/WebBlocks.png?branch=master)](https://travis-ci.org/WebBlocks/WebBlocks) [![Coverage Status](https://coveralls.io/repos/WebBlocks/WebBlocks/badge.png?branch=master)](https://coveralls.io/r/WebBlocks/WebBlocks?branch=master) [![Dependency Status](https://gemnasium.com/WebBlocks/WebBlocks.png)](https://gemnasium.com/WebBlocks/WebBlocks)

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
  include 'existing-block', 'some-other-block'
end
```

Similarly, one might add a custom block:

```ruby
require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  block 'new-block' do
    set :path, some_custom_sources_path
    scss_file '_some-file.scss'
  end
  include 'new-block'
end
```

## Usage

WebBlocks provides a `blocks` executable that wraps several commands. These commands range from `inspect`, which analyzes a WebBlocks configuration, to `compile`, which produces a WebBlocks build, and `watch`, which will reproduce a WebBlocks build every time a source file changes.

A list of all available commands is available via:

```
bundle exec blocks help
```

Each command also supports calling `help` for it, such as:

```
bundle exec blocks inspect help
```

Similarly, one may inspect sub-commands as:

```
bundle exec blocks inspect help bower_registry
```

All commands accept several global options:

* `--reload-bower` to fetch a fresh copy of Bower components rather than any already in `bower_components`. This option should be used whenever dependencies are modified in `bower.json`.
* `--reload-registry` to use a fresh copy of the registry rather than one in the cache. This option should be used if `node_modules/bower/bin/bower` is ever explicitly called.
* `--blockfile` to define a blockfile besides `Blockfile.rb` in the current working directory or nearest one in a parent directory.
* `--include` to define one or more blocks to include that aren't included by the blockfile itself. Route segments should be space-delimited, and includes should be comma-delimited: `--include efx driver tabs, efx driver toggle`. If spaces or special characters are used, then the values must be enclosed in quotes or escaped.

### Build

*NOTE: This feature is in progress. Currently, build products are saved into `.blocks/workspace/`.*

This command will link, compile and optimize a build:

```
bundle exec blocks build
```

### Watch

*NOTE: This feature is in progress. Currently, build products are saved into `.blocks/workspace/`.*

This command will watch for pertinent changes and rebuild when they occur:

```
bundle exec blocks watch
```

## Development

### Testing

Tests may be performed through `rake`:

```
rake test
```

### Partial Builds

The build process is composed of several separate steps.

These should not usually be called on their own, except for testing, debugging or advanced use cases. Their outputs may be found under `.blocks/workspace`.

##### Link

An SCSS file composed of `@import` rules may be generated into the temporary workspace:

```
bundle exec blocks link scss
```

A JS file of all JS sources concatenated together may be generated into the temporary workspace:

```
bundle exec blocks link js
```

##### Compile

The link phase is all that's needed to compose the WebBlocks Javascript; however, for SCSS, only an import sheet is generated, and thus an actual CSS file may be generated into the temporary workspace:

```
bundle exec blocks compile scss
```

### Inspect

This command is used to inspect WebBlocks configuration.

#### Bower

To get a list of components to be registered based on `bower.json`:

```
bundle exec blocks inspect bower_registry
```

#### Blocks

To get a list of blocks and files as defined by `Blockfile.rb`:

```
bundle exec blocks inspect blocks
```

To include attributes set on blocks and files:

```
bundle exec blocks inspect blocks --attributes
```

To filter within a route:

```
bundle exec blocks inspect --route="WebBlocks-visibility"
```

Note that attributes here are raw as defined by the `Blocksfile.rb` file and the `Blockfile.rb` files of registered blocks; some files with `:required = false` attributes here may still be included during dependency resolution.

#### Dependencies

To get a list of dependencies per the configuration of `Blocksfile.rb` and the blocks themselves:

```
bundle exec blocks inspect dependency_list
```

To get an list of files in the order that they will be compiled by WebBlocks:

```
bundle exec blocks inspect dependency_order
```

Both commands support a type option for the file type.

For example, to see only `scss` files:

```
bundle exec blocks inspect dependency_order --type=scss
```