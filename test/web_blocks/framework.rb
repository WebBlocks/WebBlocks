require 'test/unit'
require 'web_blocks/framework'

class TestFramework < Test::Unit::TestCase

  include WebBlocks::Framework

  def setup
    @@framework = nil
  end

  def test_singleton
    previous = framework
    @@framework = nil
    current = framework
    assert previous != current, "Setting @@framework nil in WebBlocks::Framework context destroys singleton"
    assert current === framework, "framework returns same object on subsequent calls"
  end

  def test_type
    assert framework, "framework method within WebBlocks::Framework"
    assert framework.is_a?(::WebBlocks::Structure::Framework), "framework method returns ::WebBlocks::Structure::Framework"
  end

  def test_attributes
    framework :test => true
    assert framework.get(:test), 'Attribute set from method parameters on singleton instantiation'
    framework :added_attribute => true
    assert framework.get(:added_attribute), 'Attribute set from method parameters on singleton access'
    framework do
      set :block_set_attribute, true
    end
    assert framework.get(:block_set_attribute), 'Block context executed'
    framework :block_override_attribute => false do
      set :block_override_attribute, true
    end
    assert framework.get(:block_override_attribute), 'Block context executed after attributes set from method parameters'
  end

end