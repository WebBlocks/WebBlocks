require 'pathname'

# This module contains WebBlocks-related libraries:
#
# * {WebBlocks::Framework} defines singleton accessor method framework
# * {WebBlocks::Structure} defines the structures that comprise WebBlocks
# * {WebBlocks::Support} defines supporting libraries used by WebBlocks
#
# Also see {file:REFERENCE.md full WebBlocks reference}.
module WebBlocks; end

# Require all WebBlocks library files
Dir.glob(Pathname.new(__FILE__).parent.realpath + "**/*.rb").each { |r| require r }