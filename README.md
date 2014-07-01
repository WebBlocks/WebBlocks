# WebBlocks

WebBlocks is package, configuration and dependency manager for web assets (SCSS, JS, images, and fonts).

## Status

[![Gem Version](https://badge.fury.io/rb/web_blocks.png)](http://badge.fury.io/rb/web_blocks) [![Dependency Status](https://gemnasium.com/WebBlocks/WebBlocks.png)](https://gemnasium.com/WebBlocks/WebBlocks) [![Code Climate](https://codeclimate.com/github/WebBlocks/WebBlocks.png)](https://codeclimate.com/github/WebBlocks/WebBlocks) [![Build Status](https://travis-ci.org/WebBlocks/WebBlocks.png?branch=master)](https://travis-ci.org/WebBlocks/WebBlocks) [![Coverage Status](https://coveralls.io/repos/WebBlocks/WebBlocks/badge.png?branch=master)](https://coveralls.io/r/WebBlocks/WebBlocks?branch=master)

This repository contains the code base for WebBlocks 2.0, which is currently **under development** and **not intended for use at this time**. For those interested in using WebBlocks today, please see WebBlocks 1 under the [ucla/WebBlocks](https://github.com/ucla/WebBlocks) repository.

## License

WebBlocks is open-source software licensed under the **BSD 3-clause license**. The full text of the license may be found in the [LICENSE](https://github.com/WebBlocks/WebBlocks/blob/master/LICENSE.txt) file.

## Credits

WebBlocks is managed by [Eric Bollens](https://github.com/ebollens) as part of a collaboration between the University of California, the Mobile Web Framework community and others.

WebBlocks is a product of its contributors, including those who have contributed code, submitted bugs or even simply participated in the dialogue.

WebBlocks is built on top of a number of outstanding open source platforms and packages including [Ruby](http://www.ruby-lang.org/), [RubyGems](http://rubygems.org/), [Bundler](http://gembundler.com/), [Node.js](http://nodejs.org/), [npm](https://npmjs.org/), [Saas](http://sass-lang.com/), [Compass](http://compass-style.org/), [Thor](http://whatisthor.com/), [Rake](http://rake.rubyforge.org/), [File System State Monitor](https://github.com/ttilley/fssm), [sass-css-importer](https://github.com/chriseppstein/sass-css-importer), [ruby-bower](https://github.com/kaeff/ruby-bower), [fork](https://github.com/apeiros/fork) and [extend_method](https://github.com/ebollens/ruby-extend_method). A sincere thanks is extended to the authors of all these fine tools.

## Installation

**NOTE** Assuming installation in one of the ways described as follows, this documentation uses `blocks` as a shell command; in cases where it's installed locally by bundle rather than globally, it may be necessary to use `bundle exec blocks` instead.

### Pre-requisites

The following are required:

* Ruby, RubyGems and Budler
* Node.js and NPM
* Java 1.4+ (only for compression)

### Download

#### From Source

Download or clone repository from:

> https://github.com/WebBlocks/WebBlocks

Install Ruby dependencies:

```
bundle
```

#### As Gem

To install the latest dev snapshot from RubyGems:

```
gem install web_blocks --pre
```

Or add it to your `Gemfile` (creating it if it doesn't exist):

```
gem 'web_blocks'
```

Alternatively, to get the bleeding edge, you may specify the Git repository for sources:

```
gem 'web_blocks', :git => 'https://github.com/WebBlocks/WebBlocks.git'
```

Once added to your `Gemfile`, run Bundler to install it:

```
bundle
```

### Bower

WebBlocks requires Bower to be installed.

#### Globally

The easiest way to do this:

```
npm install -g bower
```

Additionally, you must ensure that your rc file (`.bashrc`, `.zshrc`, etc.) properly sets `$NODE_PATH` to the `node_modules` directory where global installs are placed. If it does not, you may want to add something of the form:

```
export NODE_PATH=$(npm config get prefix)/lib/node_modules
```

#### Locally

An alternative is that, in the directory where you're going to compile WebBlocks (the same as where `bower.json` will be placed), you may do a local install of bower:

```
npm install bower
```

Alternatively, this can be done by defining a `package.json`:

```json
{
    "dependencies": {
        "bower":">=1.2.8"
    }
}
```

And then simply calling:

```
npm install
```

## Usage

WebBlocks provides a `blocks` executable that wraps several commands. These commands include:

* `inspect`, which analyzes a WebBlocks configuration;
* `build`, which produces a WebBlocks build;
* `watch`, which will reproduce a WebBlocks build every time a source file changes;
* `partial`, which allows one to run only one step in the build process.

Each of these have one or more actions below them, except partial, which actually has sub-commands below it, each with their own actions.

### Getting Help

To see a list of all commands:

```
$ blocks help
```

To get information about a particular command:

```
$ blocks [command [subcommand]] help [action]
```

For just a command:

```
$ blocks build help
```

For a command and action:

```
$ blocks inspect help dependency_list
```

For a command, sub-command and action:

```
$ blocks partial compile help scss
```

### Global Options

All commands (except `help`) accept several global options:

* `--base-path` defines an explicit directory where `bower.json` resides (and where `bower_components`, `.blocks` and `build` will be created). If this is not specified, WebBlocks will attempt to use the current working directory, or if there's no `bower.json` file in there, it will traverse into parent directories searching for one, exiting with a failure if neither the current working directory nor any parent contains a `bower.json` file.
* `--blockfile-path` defines an explicit Blockfile location relative to the current working directory. If this is not specified, then `Blockfile.rb` is assumed to reside in the `--base-path`.
* `--include` defines one or more blocks to include that aren't included by the blockfile itself. Route segments should be space-delimited, and includes should be comma-delimited: `--include efx driver tabs, efx driver toggle`. If spaces or special characters are used, then the values must be enclosed in quotes or escaped.
* `--reload-bower` to discard the components in `bower_components` and fetch a fresh copy. This option should be used whenever dependencies are modified in `bower.json`.
* `--reload-registry` to discard the bower registry cache and use a fresh copy. This option should be used if `node_modules/bower/bin/bower` is ever explicitly called.

### Build

This command will link, compile and produce a build into the `build` directory:

```
blocks build
```

### Watch

This command will watch for pertinent changes and rebuild into the `build` directory:

```
blocks watch
```

### Development

#### Testing

Tests may be performed through `rake`:

```
rake test
```

**NOTE** WebBlocks currently only has partial test coverage. Work is ongoing to provide full coverage.

#### Partial Builds

The build process is composed of several separate steps. These should not usually be called on their own, except for testing, debugging or advanced use cases. Their outputs may be found under `.blocks/workspace`.

##### Link

An SCSS file composed of `@import` rules may be generated into the temporary workspace:

```
blocks partial link scss
```

A JS file of all JS sources concatenated together may be generated into the temporary workspace:

```
blocks partial link js
```

##### Compile

The link phase is all that's needed to compose the WebBlocks Javascript; however, for SCSS, only an import sheet is generated, and thus an actual CSS file may be generated into the temporary workspace:

```
blocks partial compile scss
```

#### Inspect

This command is used to inspect WebBlocks configuration.

##### Bower

To get a list of components to be registered based on `bower.json`:

```
blocks inspect bower_registry
```

##### Blocks

To get a list of blocks and files as defined by `Blockfile.rb`:

```
blocks inspect blocks
```

To include attributes set on blocks and files:

```
blocks inspect blocks --attributes
```

To filter within a route:

```
blocks inspect blocks --route="WebBlocks-visibility"
```

**NOTE** Attributes here are raw as defined by the `Blocksfile.rb` file and the `Blockfile.rb` files of registered blocks; some files with `:required = false` attributes here may still be included during the link phase on account of dependency resolution. When looking at what will be required, the dependency inspection actions should be used instead.

##### Dependencies

To get a list of dependencies per the configuration of `Blocksfile.rb` and the blocks themselves:

```
blocks inspect dependency_list
```

To get an list of files in the order that they will be compiled by WebBlocks:

```
blocks inspect dependency_order
```

Both commands support a type option for the file type.

For example, to see only `scss` files:

```
blocks inspect dependency_order --type=scss
```

## Getting Started

### Defining Components

Blocks are the fundamental constituents of WebBlocks, defined as bower components. Consequently, `bower.json` must define a name and version for the build you're going to create. The name is important in that it defines the block that WebBlocks will load by default when compiling (although others may be included as dependencies or explicitly - more on this later):

```json
{
    "name": "my-app",
    "version": "1.0.0"
}
```

Further, in this example, suppose the goal is to use the `WebBlocks-visibility` block. This block resides in the Git repository [WebBlocks/block-visibility](`https://github.com/WebBlocks/block-visibility`), and thus it may be included by adding it to the `dependencies` section of `bower.json`:

```json
{
    "name": "my-app",
    "version": "1.0.0",
    "dependencies": {
        "WebBlocks-visibility": "WebBlocks/block-visibility"
    }
}
```

### Including a Block

While packages define blocks to include, generally they will not be included unless specified explicitly.

To include all of `WebBlocks-visibility`, create `Blockfile.rb` with the following:

```ruby
include 'WebBlocks-visibility'
```

This resolves out for compilation as:

```
$ blocks inspect dependency_order
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/accessible/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-breakpoints/_variables.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide-above.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/media-query/_hide.scss
```

WebBlocks has linked all WebBlocks-visibility constituents, as well as its requites - namely WebBlocks-breakpoint (which we did not specify but was rather specified in the WebBlocks-visibility [Blockfile.rb](https://github.com/WebBlocks/block-visibility/blob/master/Blockfile.rb) and [bower.json](https://github.com/WebBlocks/block-visibility/blob/master/bower.json) files).

You can build it as:

```
$ blocks build
```

Alternatively, you can perform this same operation *without* a `Blockfile.rb` defined in your workspace through the use of a command-line argument:

```
$ blocks build --include WebBlocks-visibility
```

**NOTE:** Using the `--include` flag when the base directory (where `bower.json` resides) contains a `Blockfile.rb` will lead to all inclusions occurring both that are triggered by `Blocksfile.rb` and by `--include`. To skip using a Blockfile, simply add `--blockfile-path FALSE`.

### Including Specific Sub-Blocks

WebBlocks allows one to include sub-blocks rather than just full blocks.

Based on the configuration above, let's inspect the available blocks:

```
$ blocks inspect blocks
framework (Framework)
  WebBlocks-visibility (Block)
    hide (Block)
      _hide.scss (ScssFile)
    accessible (Block)
      hide (Block)
        _hide.scss (ScssFile)
    breakpoint (Block)
      hide (Block)
        _hide.scss (ScssFile)
      hide-above (Block)
        _hide-above.scss (ScssFile)
    media-query (Block)
      hide (Block)
        _hide.scss (ScssFile)
  WebBlocks-breakpoints (Block)
    _variables.scss (ScssFile)
```

Anything designated as a block may be specified as an `include`. Returning the `Blockfile.rb`, one could tighten the block inclusion scope be replacing its current content with something like:

```ruby
include 'WebBlocks-visibility', 'accessible'
include 'WebBlocks-visibility', 'breakpoint'
```

This has tightened up the inclusions accordingly:

```ruby
$ blocks inspect dependency_order
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/accessible/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-breakpoints/_variables.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide-above.scss
```

Again, build it as:

```
blocks build
```

Alternatively, without multiple scoped includes may be specified as:

```
$ blocks build --include WebBlocks-visibility accessible, WebBlocks-visibility breakpoint
```

### Adding App-specific Sources

In this example, our `bower.json` file reads:

```json
{
    "name": "my-app",
    "version": "1.0.0",
    "dependencies": {
        "WebBlocks-visibility": "WebBlocks/block-visibility"
    }
}
```

For the purpose of this example, suppose we have two files:

* `src/app.js`
* `src/styles.scss`

These can be added to the `Blockfile.rb` as follows:

```ruby
include 'WebBlocks-visibility', 'accessible'
include 'WebBlocks-visibility', 'breakpoint'

block 'my-app' do

  set :path, 'src'

  js_file 'app.js'
  scss_file 'styles.scss'

end
```

The items under `my-app` will automatically be included because it has the same name as specified under `bower.json`. This behavior means that, if this were to be included in another project with another name, then it would not be automatically included but rather have to be included like WebBlocks-visibility in this example.

When developing an application, calling `build` can be repetitive. The `watch` command gets rid of this repetition:

```
blocks watch
```

Any time that a bower component, blockfile or source file changes, it will rebuild the necessary components.

### Using Depedencies to Control Load Order

The WebBlocks-breakpoints module provides a set of variables that it will define unless they're already defined. This enables WebBlocks-visibility's breakpoint-based classes. Suppose, however, that we wish to inject our own variables.

To start things off, create `src/config/WebBlocks-breakpoint.scss` such as:

```css
$breakpoint-xxsmall:        360px !default;
$breakpoint-xsmall:         480px !default;
$breakpoint-small:          640px !default;
$breakpoint-medium-small:   768px !default;
$breakpoint-medium:         900px !default;
$breakpoint-medium-large:   1024px !default;
$breakpoint-large:          1200px !default;
$breakpoint-xlarge:         1500px !default;
$breakpoint-xxlarge:        1800px !default;
```

**NOTE** You should always use `!default` when setting variables, so as to play nice with others who may want to explicitly define these variables earlier in the stack than your block.

Next, let's define `Blockfile.rb` as follows, including this sub-block but dropping the includes from earlier examples:

```ruby
block 'my-app', :path => 'src' do

  js_file 'app.js'
  scss_file 'styles.scss'

  block 'config', :path => 'config' do

    block 'WebBlocks-visibility' do

      scss_file 'WebBlocks-breakpoints.scss'
      reverse_dependency framework.route 'WebBlocks-breakpoints'

    end

  end

end
```

If we inspect this without any includes, the custom variables file has not been tacked on:

```
$ blocks inspect dependency_order
/Users/ebollens/Sites/test/src/app.js
/Users/ebollens/Sites/test/src/styles.scss
```

However, if we include something that requires the including of `WebBlocks-breakpoints`, which has a dependency on our config file, our config file will get included before it:

```
$ blocks inspect dependency_order --include WebBlocks-visibility breakpoint
/Users/ebollens/Sites/test/src/config/WebBlocks-breakpoints.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-breakpoints/_variables.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide.scss
/Users/ebollens/Sites/test/bower_components/WebBlocks-visibility/src/breakpoint/_hide-above.scss
/Users/ebollens/Sites/test/src/app.js
/Users/ebollens/Sites/test/src/styles.scss
```

### Working with a Existing Block

Suppose that now we decide to scrap our work with WebBlocks-visibility and instead add the [Efx](https://github.com/ebollens/efx) library to our project:

```json
{
    "name": "my-app",
    "version": "1.0.0",
    "dependencies": {
        "efx": "ebollens/efx"
    }
}
```

Additionally, we delete `Blockfile.rb`.

The blocks builder caches packages and metadata, so the first thing we need to do is reload it with the `--reload-bower` flag on any command. In this case, let's inspect the bower components with the reload:

```
$ blocks inspect bower_registry --reload-bower
efx
  /Users/ebollens/Sites/test/bower_components/efx
jquery
  /Users/ebollens/Sites/test/bower_components/jquery
```

Following this, when we call `blocks build`, we end up with empty files. If we use `blocks inspect dependency_list`, it returns an empty set. We need to explicitly choose what we wish to support:

```
$ blocks inspect blocks --attributes
framework (Framework)
  :required = true
  efx (Block)
    :required = false
    :path = "src"
    engine (Block)
      :required = true
      engine.js (JsFile)
        :required = true
    driver (Block)
      :dependencies = [["efx", "engine"]]
      :required = false
      :path = "driver"
      accordion (Block)
        :required = false
        accordion.css (ScssFile)
          :required = true
        accordion.js (JsFile)
          :required = true
      tabs (Block)
        :required = false
        tabs.css (ScssFile)
          :required = true
        tabs.js (JsFile)
          :required = true
      toggle (Block)
        :required = false
        toggle.css (ScssFile)
          :required = true
        toggle.js (JsFile)
          :required = true
```

If we wanted to include everything:

```
$ blocks build --include efx
```

If we wanted only to include the Efx engine:

```
$ blocks build --include efx engine
```

Let's settle with taking two of its drivers, tabs and toggle:

```
$ blocks build --include efx driver tabs, efx driver toggle
```

Instead of using the command-line, add this as the contents of `Blockfile.rb`:

```ruby
include 'efx', 'driver', 'tabs'
include 'efx', 'driver', 'toggle'
```

An `inspect dependency_order` shows us that, in addition to the drivers, the engine will also be included, given that it's a dependency:

```
$ blocks inspect dependency_order
/Users/ebollens/Sites/test/bower_components/efx/src/engine.js
/Users/ebollens/Sites/test/bower_components/efx/src/driver/tabs.css
/Users/ebollens/Sites/test/bower_components/efx/src/driver/tabs.js
/Users/ebollens/Sites/test/bower_components/efx/src/driver/toggle.css
/Users/ebollens/Sites/test/bower_components/efx/src/driver/toggle.js
```

### Modifying a Existing Block

The WebBlocks DSL allows one to re-open an existing block.

In the case of the [Efx](https://github.com/ebollens/efx) library, the author did not want to impose jQuery as part of the block's build process, in case the user is included it elsewhere; however, in the case of our particular app, we may want to bundle the two together.

Looking at our registry, we see that, although jQuery is not being included as part of the actual build, it is defined as a bower dependency:

```
$ blocks inspect bower_registry
efx
  /Users/ebollens/Sites/test/bower_components/efx
jquery
  /Users/ebollens/Sites/test/bower_components/jquery
```

Since jQuery doesn't have a `Blockfile.rb` in it's repository, we'll start by adding that definition to `Blockfile.rb`:

```ruby
include 'efx', 'driver', 'tabs'
include 'efx', 'driver', 'toggle'

block 'jquery', :path => 'bower_components/jquery/dist' do
  js_file 'jquery.js'
end
```

Next, also within `Blockfile.rb`, we'll open the `efx` block and add the dependency:

```ruby
include 'efx', 'driver', 'tabs'
include 'efx', 'driver', 'toggle'

block 'jquery', :path => 'bower_components/jquery/dist' do
  js_file 'jquery.js'
end

block 'efx' do
  dependency framework.route 'jquery'
end
```

Inspecting shows this has the intended effect:

```
$ blocks inspect dependency_order
/Users/ebollens/Sites/test/bower_components/jquery/dist/jquery.js
/Users/ebollens/Sites/test/bower_components/efx/src/engine.js
/Users/ebollens/Sites/test/bower_components/efx/src/driver/tabs.css
/Users/ebollens/Sites/test/bower_components/efx/src/driver/tabs.js
/Users/ebollens/Sites/test/bower_components/efx/src/driver/toggle.css
/Users/ebollens/Sites/test/bower_components/efx/src/driver/toggle.js
```

### Learn More

See the `demo` folder for a example setup.
