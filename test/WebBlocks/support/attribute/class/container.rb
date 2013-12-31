require 'test/unit'
require 'WebBlocks/support/attributes/class/container'

class TestSupportAttributesClassContainer < Test::Unit::TestCase

  class Container
    class << self
      include WebBlocks::Support::Attributes::Class::Container
    end
  end

  def setup
    @name = Container.name
  end

  def test_type
    assert Container.attributes.is_a? Hash
    assert Container.attributes(@name).is_a? Hash
  end

  def test_set
    assert Container.attributes(@name).length == 0
    Container.set :test1, :value
    assert Container.attributes(@name).is_a? Hash
    assert Container.attributes(@name).length == 1
    assert Container.attributes(@name)[:test1] == :value
  end

end