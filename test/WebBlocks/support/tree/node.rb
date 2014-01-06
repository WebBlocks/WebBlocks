require 'test/unit'
require 'WebBlocks/support/tree/node'

class TestSupportTreeNode < Test::Unit::TestCase

  class Node
    include ::WebBlocks::Support::Tree::Node
  end

  def test_name
    node = Node.new('name')
    assert node.name == 'name'
    assert_raise NoMethodError do
      node.name = 'test'
    end
  end

end