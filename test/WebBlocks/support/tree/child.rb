require 'test/unit'
require 'WebBlocks/support/tree/child'

class TestSupportTreeChild < Test::Unit::TestCase

  class Child
    include ::WebBlocks::Support::Tree::Child
  end

  class Parent
    attr_accessor :child
    # stub method that just sets @child as child rather than adds to array - just for testing purposes
    # real version in WebBlocks::Support::Tree::Parent adds it to a children array
    def add_child parent
      @child = parent
    end
  end

  class ChildWithName < Child
    attr_reader :name
    def initialize name
      @name = name
    end
  end

  def test_parent
    child = Child.new
    assert child.respond_to? :parent
    assert child.parent == nil
  end

  def test_set_parent
    child = Child.new
    parent = Parent.new
    child.set_parent parent
    assert child.parent === parent
    assert parent.child === child
  end

  def test_set_parent_no_add_child_method
    child = Child.new
    parent_without_add_child = Child.new
    child.set_parent parent_without_add_child
    assert child.parent === parent_without_add_child
  end

  def test_parents
    child = Child.new
    parent = Child.new
    parent_parent = Child.new
    child.set_parent parent
    parent.set_parent parent_parent
    assert child.parent === parent
    assert parent.parent === parent_parent
    parents = child.parents
    assert parents[0] === parent
    assert parents[1] === parent_parent
  end

end