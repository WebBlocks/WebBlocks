require 'test/unit'
require 'WebBlocks/support/tree/parent'

class TestSupportTreeParent < Test::Unit::TestCase

  class Parent
    include ::WebBlocks::Support::Tree::Parent
  end

  # stub to check named node association
  class NamedNode
    attr_reader :name
    def initialize name
      @name = name
    end
  end

  # stub to check proper call of add_parent
  class Child < NamedNode
    attr_reader :parent
    def set_parent parent
      @parent = parent
    end
  end

  def test_children
    parent = Parent.new
    assert parent.children.is_a? Hash
    assert parent.children.size == 0
  end

  def test_add_children

    parent = Parent.new
    child = Child.new 'name'

    parent.add_child child
    assert parent.children.is_a? Hash
    assert parent.children.size == 1
    assert parent.children.has_key? 'name'
    assert parent.children['name'] === child
    assert child.parent === parent
    assert parent.has_child? 'name'

    child2 = Child.new 'name2'

    parent.add_child child2
    assert parent.children.size == 2

    parent.remove_child 'name2'
    assert parent.children.size == 1
    assert parent.children.has_key? 'name'
    assert parent.has_child? 'name'
    assert !parent.children.has_key?('name2')
    assert !parent.has_child?('name2')

  end

  # Should use object as key if no #name method exists
  def test_add_children_no_name
    parent = Parent.new
    child_without_name = Parent.new
    parent.add_child child_without_name
    assert parent.children.has_key?(child_without_name)
    assert parent.children[child_without_name] == child_without_name
    assert parent.has_child? child_without_name
    parent.remove_child child_without_name
    assert !parent.has_child?(child_without_name)
  end

  def test_add_children_no_set_parent
    parent = Parent.new
    named_node = NamedNode.new 'name'
    assert_nothing_raised do
      parent.add_child named_node
    end
    assert parent.children.has_key? 'name'
    assert parent.children['name'] === named_node
  end

end