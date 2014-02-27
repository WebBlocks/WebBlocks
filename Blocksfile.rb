require 'WebBlocks/framework'
include WebBlocks::Framework

framework do

  include 'WebBlocks-visibility', 'breakpoint'
  include 'WebBlocks-visibility', 'accessible'

end

framework do

  block 'src', :required => true, :path => Pathname.new(__FILE__).parent + 'src' do

    block 'config', :path => 'config' do

      block 'WebBlocks-breakpoints' do

        scss_file 'WebBlocks-breakpoints.scss'
        reverse_dependency framework.route 'WebBlocks-breakpoints'

      end

    end

  end

end