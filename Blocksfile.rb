require 'WebBlocks/framework'
include WebBlocks::Framework

framework do
  block 'WebBlocks-visibility' do
    block 'hide', :required => false
  end
  include 'WebBlocks-visibility', 'breakpoint'
end