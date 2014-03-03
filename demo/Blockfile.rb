# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# BLOCKSFILE EXAMPLE
#
# This file is intended to showcase some of the common features available to Blocksfile.rb. In production, it is likely
# that helpers will be used to cut down on boilerplate. Additionally, Blocksfile.rb is pure Ruby, so it supports being
# split into a number of files for organizational purposes.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#
# CUSTOM BLOCK DEFINITIONS
#
# In some cases, the existing definitions do not behave as desired, so reopen and modify accordingly.
#

# The efx block does not enforce a dependency on jQuery so add that here.
block 'efx' do
  dependency framework.route 'jquery'
end

#
# BLOCK INCLUSIONS
#
# This registration defines which blocks will be included in the build.
#

include 'WebBlocks-visibility', 'breakpoint'
include 'WebBlocks-visibility', 'accessible'

include 'efx', 'driver', 'accordion'
include 'efx', 'driver', 'tabs'
include 'efx', 'driver', 'toggle'

# also valid would be either of these to include all efx drivers:
#   include 'efx', 'driver'
#   include 'efx'



#
# CUSTOM SOURCES
#
# This defines an 'src' block intended to for application-specific sources.
#

block 'WebBlocks', :path => Pathname.new(__FILE__).parent + 'src' do

  block 'config', :path => 'config' do

    block 'WebBlocks-breakpoints' do

      scss_file 'WebBlocks-breakpoints.scss'
      reverse_dependency framework.route 'WebBlocks-breakpoints'

    end

  end

end
