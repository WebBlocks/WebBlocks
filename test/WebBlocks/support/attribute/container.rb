require 'test/unit'
require 'WebBlocks/support/attributes/container'

class TestSupportAttributesContainer < Test::Unit::TestCase

  class Container
    include WebBlocks::Support::Attributes::Container
  end

  class ClassContainer
    class << self
      include WebBlocks::Support::Attributes::Class::Container
    end
    include WebBlocks::Support::Attributes::Container
    set :container, :container_value
    set :container_overridden, :container_value
  end

  class ContainerWithClassContainers < ClassContainer
    class << self
      include WebBlocks::Support::Attributes::Class::Container
    end
    include WebBlocks::Support::Attributes::Container
    set :container_overridden, :container_overridden_value
  end

  def test_has_get_set
    container = Container.new
    assert !container.has?(:key)
    container.set(:key, :value)
    assert container.has?(:key)
    assert container.get(:key) == :value
    hash = container.set(:key2, :value2)
    assert hash[:key] == :value
    assert hash[:key2] == :value2
  end

  def test_class_attributes
    container = ContainerWithClassContainers.new
    class_attributes = container.class_attributes
    assert class_attributes[:container] == :container_value
    assert class_attributes[:container_overridden] == :container_overridden_value
  end

  def test_attributes_with_inheritance
    container = ContainerWithClassContainers.new
    assert container.get(:container) == :container_value
    assert container.get(:container_overridden) == :container_overridden_value
  end

  def test_attributes_inheritance_with_override
    container = ContainerWithClassContainers.new
    container.attributes :container => :instance_override,
                         :container_overridden => :instance_override
    assert container.get(:container) == :instance_override
    assert container.get(:container_overridden) == :instance_override
  end

  def test_push
    container = Container.new
    container.set :arr, []
    container.push :arr, :val1
    assert container.get(:arr).length == 1
    container.push :arr, :val2
    arr = container.get(:arr)
    assert arr.length == 2
    assert arr[0] == :val1
    assert arr[1] == :val2
  end

end