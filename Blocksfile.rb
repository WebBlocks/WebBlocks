# BLOCKSFILE EXAMPLE
#
# This file is intended to showcase some of the common features available to Blocksfile.rb. In production, it is likely
# that helpers will be used to cut down on boilerplate. Additionally, Blocksfile.rb is pure Ruby, so it supports being
# split into a number of files for organizational purposes.

require 'WebBlocks/framework'
include WebBlocks::Framework

# CUSTOM BLOCK DEFINITIONS
#
# Ideally, frameworks and tools should include Blockfile.rb; however, this will not always be the case. In some cases,
# frameworks may not explicitly support WebBlocks (even though, through this syntax, WebBlocks can support them), and,
# in others, it may be advantageous simply to download a build product.

framework do

  # Adding a custom block based on the download of jQuery as specified by bower.json
  block 'jquery-build', :path => 'bower_components/jquery-build' do
    js_file 'index.js'
  end

  # Adding a dependency on the jquery-build block for efx to include jquery if including efx
  block 'efx' do
    dependency framework.route 'jquery-build'
  end

end

# BLOCK REGISTRATION
#
# This registration defines which blocks will be included in the build.

framework do

  include 'WebBlocks-visibility', 'breakpoint'
  include 'WebBlocks-visibility', 'accessible'
  include 'efx', 'driver', 'accordion'
  include 'efx', 'driver', 'tabs'
  include 'efx', 'driver', 'toggle'

end

# CUSTOM SOURCES
#
# This defines an 'src' block intended to for application-specific sources.

framework do

  block 'src', :path => Pathname.new(__FILE__).parent + 'src' do

    block 'config', :path => 'config' do

      block 'WebBlocks-breakpoints' do

        scss_file 'WebBlocks-breakpoints.scss'
        reverse_dependency framework.route 'WebBlocks-breakpoints'

      end

    end

  end

  include 'src'

end