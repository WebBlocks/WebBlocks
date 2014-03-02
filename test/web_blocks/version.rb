require 'test/unit'
require 'web_blocks/framework'

class TestVersion < Test::Unit::TestCase

  def test_version
    assert_nothing_raised("VERSION constant initialized"){ WebBlocks::VERSION }
  end

end